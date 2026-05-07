Return-Path: <netdev+bounces-285414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F8lKHi4/GkqTAAAu9opvQ
	(envelope-from <netdev+bounces-285414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:06:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DD4EBCB8
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 18:06:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D7F30A270E
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 15:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEF244B697;
	Thu,  7 May 2026 15:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nUUCB+NZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46A516F27F
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 15:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778169495; cv=none; b=XtQ7anVagP+IahFzVT7tzRfaMDv8uJCesyyvxioYWcf11O38rfL6OSzsz3p15tdLW+ZMKY2Dd/8ceMVzkLwQO9LwcoAxl0iZZWOstsNVGWtwWtu1n7uQWv7p993FDTxzbDJOGziTSL+oF3iFpzCFATDKWXEwPm0glvABCQmmUfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778169495; c=relaxed/simple;
	bh=yUPZSU/RAI7NZX30XKkeoDo+fV9Xk6+F0T3f/kT3hJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NKkquyJCTuFtPh18ILmTndSRLi9c5+w3zdHTBmLn6NF4hBcVwmAvUMvaWVss1UUDDzJocgfLr4PGfwLef8H0K1juoAW7ej6RLHc6QA6M4lgpuIjhtv/iXfjx0+YWHh4eVmXnw88am/fGUYe6aAIxoqVHlYphU8lG6+gDjZcNtwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nUUCB+NZ; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50faeb8317bso7104811cf.2
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 08:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778169493; x=1778774293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wKmetoEaYW+UnWgwBZ5g2dNY5J9Q0ejlO9aOCjwQNe0=;
        b=nUUCB+NZA0XMm1nLRRRNeZ3jdB0uN9BNjMS8E0jyV2diQiP7YZVpkJsMzrCVZA3o26
         nlPthgvDsfFtNBwUIYJNslGWRmdQq0qkSzDw2EOtCH9zWO2qmUYMn91zTzfEBW6rcFrE
         v2KmWWIiH7XkGSSVm03bO6GIoebmfe3R7X7Sgak2TdL36JPwFgjEM/KREfS0PwPLaUL/
         LOfs4KWkgHYeoNL/nPyuKkWMBvP4d7UZWUvntmDIEs9i/3co/nSgX2g18OyTBR4gwXzW
         7QxWlnoFq2P6L/rAOAiX4CHxbn3jTBPGTSW8yZ5oO4cqBjgNpipouGK+rj3j0bvXQoei
         xkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778169493; x=1778774293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wKmetoEaYW+UnWgwBZ5g2dNY5J9Q0ejlO9aOCjwQNe0=;
        b=SwQQpHh6aV9GCdhJMsV/8mZKd1KWYPc6xFMUEUUrsbM2PdEH9TjR2K7lKy7lYPei7R
         n7RdYPuOokCwFHWYxHgbZpSVeyniUGisugIsJCTALeLoZrcwWpYWNnA0SHULBIzreAes
         xHCE7KzNBZy5QCVngRcwaE/l641MeYZV+4+gm2s4B3ybvH2tF0oZs5tKLcP+a6F6WW7y
         eFChOFtZTArK8QWmXFKJRcvea2u/SfOSoNWPQIJR7Kf6+W4xZFf1SvnvDuP0/uum6tL/
         e9jppXYfz4MT4MACPxHyMqv+z0D84ondLA2p7gO3bDva5wbMbruBevrRAmfinJaaVlhd
         oEZQ==
X-Forwarded-Encrypted: i=1; AFNElJ/TO66j55rDlCwQ7qnA/V/Dk60X9RSvHrl7mn/Tfnhj1k/1zSCzxBo3teHKvNGO1G3NUUNjuGc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqiUQ08ttdgeP460aTedOHL2Y662932VizXgp9ugZkhv5rDSyW
	SKBrOxx8OfGZZMMzAVJSGty/19d/NUips549HmV9Hd14DcFkfFLvwVj4Yef8bUhf
X-Gm-Gg: AeBDievmF+eQVFmtG473/p5w0IkdP2VBDw0O61J7QqBZuL5MO52hopE3hngut8hv1v9
	GJYheNfW/tpc9CiraEJjKUOYFOEJj+FskXRHCxBEHxYz6LmhJnBs7XP69Hix4lsr6/q17Tmk3tr
	oADb2WayNk2LTZKxlfodDbRH/MbxCGuaFg3nQsXl4DnCfaS+97XE9JZFXeEG4GCzDvgj9c45sXa
	Q8XUa4FP+lYuADHF3YOSYtkWWLatxcTywXNHMIc/72PcPNIIa6FlSSh3Bs00a3wJOvzegfn/S0D
	DVjRVCqXBzZuKclbDtwYZr6h7uS5ilt8gq1upLuqy68QZE5KZ9LMAHuOAlJqia/PnFvMN1d19lL
	hzd2W/3OdVCiaHTGLJMN4cX1ZZBCO0SlqLKzcBc9eFhyWjlCZjJw/b9BngXCCwzG1Q+46fP/ROW
	GUyu+NXasm9uGTzMO0tVWDqhnIXrZWOzHTNmfpe8E/za2DA9E9o52pUEZ7M8WcREgGIvQ=
X-Received: by 2002:a05:622a:4d49:b0:510:1463:4fc3 with SMTP id d75a77b69052e-51461154c3amr121495981cf.0.1778169492080;
        Thu, 07 May 2026 08:58:12 -0700 (PDT)
Received: from PF5YBGDS.localdomain ([163.114.130.6])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-514850f3cc8sm522421cf.8.2026.05.07.08.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 08:58:11 -0700 (PDT)
Date: Thu, 7 May 2026 11:58:09 -0400
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Simon Horman <horms@kernel.org>, Lee Trager <lee@trager.us>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: eth: fbnic: Fix addr validation in
 pcs write
Message-ID: <afy2kYKcc8MXufV4@PF5YBGDS.localdomain>
References: <20260504135815.44226-1-mike.marciniszyn@gmail.com>
 <20260504135815.44226-2-mike.marciniszyn@gmail.com>
 <20260506185819.1c68a71b@kernel.org>
 <1cd8256c-286a-4a73-b0a0-89233cb3c2d0@redhat.com>
 <afyRrWW8XVeO55Ob@PF5YBGDS.localdomain>
 <afyYJ9-qW_QG6f7_@PF5YBGDS.localdomain>
 <ee4fb21a-2420-4e35-9798-413eb3619dc6@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee4fb21a-2420-4e35-9798-413eb3619dc6@redhat.com>
X-Rspamd-Queue-Id: 268DD4EBCB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285414-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,fb.com,meta.com,lunn.ch,davemloft.net,google.com,gmail.com,armlinux.org.uk,intel.com,trager.us,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[PF5YBGDS.localdomain:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 07, 2026 at 03:50:04PM +0200, Paolo Abeni wrote:
> On 5/7/26 3:48 PM, Mike Marciniszyn wrote:
> > On Thu, May 07, 2026 at 09:20:45AM -0400, Mike Marciniszyn wrote:
> >> On Thu, May 07, 2026 at 09:20:53AM +0200, Paolo Abeni wrote:
> >>> On 5/7/26 3:58 AM, Jakub Kicinski wrote:
> >>>> On Mon,  4 May 2026 09:58:12 -0400 mike.marciniszyn@gmail.com wrote:
> >>>>> From: "Mike Marciniszyn (Meta)" <mike.marciniszyn@gmail.com>
> >>>>>
> >>>>> The DW IP has two distinct PCS address ranges cooresponding
> >>>>> to the C45 PCS registers.
> >>>>>
> >>>>> The shim translates the PCS addr/regno into specific CSR writes
> >>>>> into one of those two zero-relative.
> >>>>>
> >>>>> This patch fixes a one off in the test that could allow an invalid
> >>>>> CSR write if an addr == 2 was called.
> >>>>>
> >>>>> This patch contains a fix for addr validation in fbnic_mdio_write_pcs()
> >>>>> to only return actual CSR reads for addr 0 and 1.
> >>>>>
> >>>>> There are as of yet, no real impact for the bug as no PCS writes are
> >>>>> not yet present.
> >>>>
> >>>> Hi Paolo! Was there a reason / do you recall why this was not applied?
> >>>> (I dropped it from patchwork now. If the omission was accidental it has
> >>>> to be reposted)
> >>>
> >>> Darn, limited capacity here plus re-submission glitch: v3 had a slightly
> >>> different cover title (due to typo) WRT v2 so PW did not mark v2 as
> >>> superseded. I process patches via PW in sequence, when I reached v2 I
> >>> considered the sashiko comment not blocking and I apply it. I was unable
> >>> to reach v3 until now.
> >>>
> >>> TL;DR: @Mike: please re-submit 1/4 and double check there are not other
> >>> differences between v2 and v3 - otherwise more patches needed. Also
> >>> please ensure you keep the series title consistent among revision, or at
> >>> least manually remove old revisions from PW upon resubmission.
> >>>
> >>> Thanks,
> >>>
> >>> Paolo
> >>>
> >>
> >> I double checked v2 -> v3 for the other patches are ok.
> >>
> >> I'm just now resending 1/4 of the series.  I reworded the commit message
> >> to fix the AI review comment.
> >>
> >> Mike
> >
> > The patch isn't showing up on either lore or patchwork.
> >
> > I may need to bump the rev?
>
> Wait a bit more. 1h latency can happen quite easily.
>
> /P
>

The patch in is patchwork:
https://patchwork.kernel.org/project/netdevbpf/patch/20260507154203.3667-1-mike.marciniszyn@gmail.com/

Mike

