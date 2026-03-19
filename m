Return-Path: <netdev+bounces-269591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIafGbE3vGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:51:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4912D0505
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:51:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52B6A300138A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF413E7143;
	Thu, 19 Mar 2026 17:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YFF1sqVu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5FA838AC89;
	Thu, 19 Mar 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773942671; cv=none; b=AD/h9z1LK947GCVjerkFlMTFZ1C4WNgUtm28pdt1PJBjbHif/7oNSTY6xq3feyNI1gpKJPlZzN02dLFT/a3bwFde4w2ZhPFjbUSRF+adBtcsNHghZsfjCS3YnleFAOPikU9KV2KFlxN0ZVQT1B4KnKG4/ZnUvL2TuUGPnpAHbX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773942671; c=relaxed/simple;
	bh=P4nEYDIFq57dZDYX3ktkthGpLNQSwZEtxdpf0lSyWuc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SeaUXMYoi+OwB8LifMLB5FkwPVfWoSiV7VZnrERIbrBaw3054VABC8K0PbwFXBwNa+k5CwrPOM1FL7LMuenKzSpCzJxLQrCDNhINz1tjoTyL3i5CMHis8R6h4i4//ZJFveH1yt+qUhe6/bKWvhFPv5oVwIHHTk+Ue7DfqYRtFng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YFF1sqVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE4FC19424;
	Thu, 19 Mar 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773942671;
	bh=P4nEYDIFq57dZDYX3ktkthGpLNQSwZEtxdpf0lSyWuc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YFF1sqVu9ayD7RFRYegabF1tVKx6PRxS74YjDAvynIKOWriBanO1cCcMWlF7QNY2m
	 2R+5/Y8bBYaa0hr727MzzIf2pPn0SoxGW1lS+qvmVRdszw6hiiXmz1rNMXwTvQAfF/
	 19va8p/zCf8mk4EyzYsfQWtahMvnpQ9JjijBeyUnaYF1+MSjE/d2JWM3KblU8tT6eX
	 3XCzP4KMs+gRRqtddSeY+JergInfvnRLl5yAlvkDgfZux5UE0mCXlz84Y5aqZ8uJ2N
	 TaP2jFwPVeNa51tQ+jmbTFLjWWRkwiYCDijqK5nzswBGwkUTAZRP9W2nCmOE6mnP4m
	 2D/yaVXCd2Mbw==
Date: Thu, 19 Mar 2026 17:51:06 +0000
From: Simon Horman <horms@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v2] net: fjes: Drop fjes_acpi_driver and rework
 initialization
Message-ID: <20260319175106.GQ1753385@horms.kernel.org>
References: <12857407.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12857407.O9o76ZdvQC@rafael.j.wysocki>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269591-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.974];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 6A4912D0505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 02:43:55PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> The ACPI driver interface used by the Fujitsu Extended Socket (fjes)
> Network Device driver is redundant because its only role is to create
> a platform device the fjes platform driver can bind to, which can be
> done already at the module initialization time.
> 
> Namely, acpi_find_extended_socket_device() looks for the requisite ACPI
> device object anyway and it may as well check its resources, and the
> platform device can be created when the ACPI object in question
> has been found (and it can be freed when the module is unloaded).
> 
> Moreover, as a rule, it is better to avoid binding drivers directly to
> ACPI device objects [1].
> 
> Accordingly, drop fjes_acpi_driver, adjust the module initialization
> and exit code as per the above and set the fwnode for the fjes platform
> device to point to the corresponding ACPI device object as its ACPI
> companion.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> v1 -> v2: Add platform device unregistration to the rollback path in
>    fjes_init_module, as per
> https://lore.kernel.org/linux-acpi/CAJZ5v0g9BinHfQDS6hUvVHdLxDPvbv7ck=m1Bqa=+C3iE+vgxw@mail.gmail.com/

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


