Return-Path: <netdev+bounces-268685-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KL9LBL2DuWlyIgIAu9opvQ
	(envelope-from <netdev+bounces-268685-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:39:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 118212AE27D
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 65B5A304332A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 16:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A23C3783D1;
	Tue, 17 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UNVMmiLc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56DBD377572;
	Tue, 17 Mar 2026 16:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773765140; cv=none; b=hq4PjIIaPh/D35Y+9MUKbjLJrE9mSlrVYB107k73HUWVW4yLJMKAw8ilOc33CSYrCrnRh5pY1drpMQSDOqPFyt9G4T6EDDfdmcvGJTfoxpcmaBRsH+d2M4Gg3rtvOYHCCQ69/tMb3FyfxIkb2JffEvHPRPGL2wJnc/JiMIpoMv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773765140; c=relaxed/simple;
	bh=8NOEMxfPkcH9K8TEbGismoeO9TvyxCj+fwHnNVOBfM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6GHlAQor1T+yELmfvVAFlp/1Vm7584bU6DD3biGj2nk04YCvNazURcdLBlFPXpn0D8AhleR/vMiFj25GDOxNgRcVEuUYS6B0igw7htp/sdfSNTQOW0egm7r+qDzi/NseqKVMSSllJ/VGZAEj7MedMdSjdROjmqEYvU2gswiY68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UNVMmiLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053EDC4CEF7;
	Tue, 17 Mar 2026 16:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773765140;
	bh=8NOEMxfPkcH9K8TEbGismoeO9TvyxCj+fwHnNVOBfM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UNVMmiLcYsv+j82Aqf8MncjQLuPjNA703tmZmA7r0O8/nUE1SAdWoznpgywiH6BMH
	 2Ho7hl8WMV6TXAnXVIEZ1F+eu+B8Qs97Beg6bxkSb7PAc21PfcuGwP9q44Tz9V+pwf
	 aTqbbZiIrXRAAX9X7c3x7pazr4ocpkj66/kqfIYsCdm0CKwzNxR5wD09YgUTdGKnoA
	 9aY3bFKCUPaCqfl5R0ZtayFq53TnBQXli8dhokw9gIptNMnWvMjQ+nRmUV3RRdpM9S
	 DtgvOsEeC0aOzuzv/pzACyhScv8m5ZYSAB/7MjVTGqqMcBHHKrXY+s1rsfxangcPh5
	 HDVEhsXZ8E3IA==
Date: Tue, 17 Mar 2026 16:32:15 +0000
From: Simon Horman <horms@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH v1] ptp: vmw: Convert to a platform driver
Message-ID: <20260317163215.GA1753385@horms.kernel.org>
References: <12883468.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <12883468.O9o76ZdvQC@rafael.j.wysocki>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_FROM(0.00)[bounces-268685-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 118212AE27D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 14, 2026 at 12:43:33PM +0100, Rafael J. Wysocki wrote:
> From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> 
> In all cases in which a struct acpi_driver is used for binding a driver
> to an ACPI device object, a corresponding platform device is created by
> the ACPI core and that device is regarded as a proper representation of
> underlying hardware.  Accordingly, a struct platform_driver should be
> used by driver code to bind to that device.  There are multiple reasons
> why drivers should not bind directly to ACPI device objects [1].
> 
> Overall, it is better to bind drivers to platform devices than to their
> ACPI companions, so convert the PTP VMware ACPI driver to a platform
> one.
> 
> While this is not expected to alter functionality, it changes sysfs
> layout and so it will be visible to user space.
> 
> Link: https://lore.kernel.org/all/2396510.ElGaqSPkdT@rafael.j.wysocki/ [1]
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


