Return-Path: <netdev+bounces-253918-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOhcGHvYeGmftgEAu9opvQ
	(envelope-from <netdev+bounces-253918-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:23:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CE29E969B6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15BE30B0F79
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 15:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8CF35CBA5;
	Tue, 27 Jan 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bvKs1oAg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC7311C3B;
	Tue, 27 Jan 2026 15:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526583; cv=none; b=ploRvKNJ1ZGyUK5Q2OoJfyNGmmAON6P4MEzlnUa0z+3A9G070fbom8zsSJUisiBa3W9eCGbg1sLCcCSLH09pvjGs14H4u6biccPXoZB6nyM13S35eHCUDPJXeqqZnYnU++8JA/2B3qm9JYPlHC1p0cLk8m60cOOmglnkelw6RNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526583; c=relaxed/simple;
	bh=rmNQL/xtQBGnPI2ZlGhNFoHcL1rwnzlS69h5xZXLWa0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EsM0p2NXDXOrx4UsQ/o3reOic+cVllE0KDIaSYl1MtQzYSx5cVAR2fFyUfPdH+Aa7mOKF0l4LY8k5vs/KJi1hMfi8WcEYRjda994+PY7ctg9vg/S03PBzoidcbeVi+KVH0pfQ2IJKyPUWnaqDFIIx057bynA1UOaxUDj44ZA9As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bvKs1oAg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E123CC116C6;
	Tue, 27 Jan 2026 15:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769526583;
	bh=rmNQL/xtQBGnPI2ZlGhNFoHcL1rwnzlS69h5xZXLWa0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bvKs1oAgCX6aSY70/RdHou4QR7wEXg9Kk6pwd4hDkCnS3qQVORwLThjz9JW67Tqrn
	 W1yM8nRalJ2dnKZzTkiJXY2kGfO/dWiEpDrxzQJtu340SQKspOZ2bbOsLdgfzFMshx
	 BXborf7SjsTZJgpYXy8l8F0yhK6ZsPqQgvoSRGl8=
Date: Tue, 27 Jan 2026 16:09:40 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivan <kernvirt@gmail.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [BUG] r8152: Tx timeout and xHCI setup device timeout. RTL8153
 31.00
Message-ID: <2026012720-outmatch-worry-b92d@gregkh>
References: <CAOf3c5fDit7nvfWUGf+f5Ctmfr9ebg6KqiwZhZYusHyFaeE5CQ@mail.gmail.com>
 <2026012758-dedicate-desecrate-358a@gregkh>
 <CAOf3c5eJp7432wRk1E0cDTWMccO_m9fWYDKU25-qJ7Owk8mVQA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOf3c5eJp7432wRk1E0cDTWMccO_m9fWYDKU25-qJ7Owk8mVQA@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253918-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: CE29E969B6
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 05:38:36PM +0300, Ivan wrote:
> The USB hub is brand new. Honestly, I don't even know how to trigger
> this bug; it happens completely randomly.
> The chip does not overheat. I performed a stress test using iPerf,
> where the router acted as the server and my machine as the client,
> receiving traffic at 1 Gbps with 10 parallel streams. Simultaneously,
> I kept a USB flash drive in the hub, continuously reading data from
> it. The system remained stable for over 30 minutes without any issues,
> then I terminated the test.
> This specific crash today occurred right after downloading 900MB of
> packages. Apologies for the previous log; this time I have attached
> the full journalctl log for better context.

Looks like the device disconnected right after booting, not after being
used for a while.  Are you sure that was the correct log?

thanks,

greg k-h

