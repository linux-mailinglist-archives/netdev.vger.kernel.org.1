Return-Path: <netdev+bounces-260415-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8N88BzJrnWnhPwQAu9opvQ
	(envelope-from <netdev+bounces-260415-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:11:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC5A1844D7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 10:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17A873030D38
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79CDD368262;
	Tue, 24 Feb 2026 09:06:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3483346A0;
	Tue, 24 Feb 2026 09:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.136.29.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924007; cv=none; b=DGcB+bJgcnu/9X5DAqYuvY8tL/GuYJW0xigW+LxvF1ctLXyO2DS7LkSkcz1Slv07M6UY8GrvUw1WMHaihqF7JA4MWP9LqeDl/y/FAoY4RkqREIIVwK7pWXnaCD6uoDTnbb+a0yCKhYP7kqRfU69qSYceuXxT9HdjZ87zcP4oqtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924007; c=relaxed/simple;
	bh=IFtfCARgW5leN3qTPPYGf/aEdNDYKoPYRTam8eoW3q8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FKQHryc5WDYYuj38QfmhvMoUmn8EuSkiV2qnp3NhbqHB6VTF3DIZdSmbCzH+IE5CGZzgU1myzR5p77SHIRy/p1LckcWB38z6CBRJykHhtK++273UTgIIJPn5N8oB0DfNwmCnAvsgkJG6u3XmJRKvNqjkFCzO94pooQbF0FVysdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com; spf=pass smtp.mailfrom=proxmox.com; arc=none smtp.client-ip=94.136.29.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 1966948068;
	Tue, 24 Feb 2026 10:06:42 +0100 (CET)
Date: Tue, 24 Feb 2026 10:06:41 +0100
From: Gabriel Goller <g.goller@proxmox.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] docs: net: document neigh gc_interval and
 gc_stale_time sysctls
Message-ID: <b4z6x2djckenphenqpz3sfnqa6gnahvbxwpycvoicgpbsqx3tg@jbrrvrz7g4h5>
Mail-Followup-To: Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260219162200.510325-1-g.goller@proxmox.com>
 <zevfldlqbbprujyld3v3jdl7jlifbmn7ixhrdcpyj34eepv7m4@j55q7mptwqyt>
 <20260223145809.2369117c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260223145809.2369117c@kernel.org>
User-Agent: NeoMutt/20241002-35-39f9a6
X-Bm-Milter-Handled: 55990f41-d878-4baa-be0a-ee34c49e34d2
X-Bm-Transport-Timestamp: 1771923985989
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.968];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	DMARC_NA(0.00)[proxmox.com];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[g.goller@proxmox.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-260415-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 8BC5A1844D7
X-Rspamd-Action: no action

On 23.02.2026 14:58, Jakub Kicinski wrote:
> On Mon, 23 Feb 2026 11:23:29 +0100 Gabriel Goller wrote:
> > Superseded by:
> > - [PATCH net-next v2] docs: net: document neigh gc_stale_time sysctl
> >   https://lore.kernel.org/netdev/20260223101257.47563-1-g.goller@proxmox.com/
> > 
> > --
> > pw-bot: superseded
> 
> Where did you get the idea to send this email??

Haha, I changed the title of the patch in the new version, so Patchwork
didn't automatically recognize it and mark the old one as superseded.

I saw in Documentation/process/maintainer-netdev.rst that there's a way
to manually set the state to superseded using pw-bot commands. However,
it turns out I don't have the necessary permissions to do that :)


