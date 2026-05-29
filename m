Return-Path: <netdev+bounces-293210-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLQXFcfjGWrrzggAu9opvQ
	(envelope-from <netdev+bounces-293210-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:06:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8589607B31
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:06:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4270B30BCAF8
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 18:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7A243636E;
	Fri, 29 May 2026 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qygqTzKe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE45142DFF2
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780080307; cv=none; b=S3cLH8MSuWRDL6vk0zc3cIePwz7WRQ2CTqEHsssnUP1uzRuaK1fesBplFzSvm+5Vmt0vmnDj6Glq6NthiLis54EvLwLX4CVaBkPiyaFuobWyFkwU+FtYOmk9kqVF3jDMmpt3Kl1UsGD+c+JaQOCGacbb6UIeVJe58Ni1VjMymI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780080307; c=relaxed/simple;
	bh=KjM2Ni9kLOHksR3CwYDNLPuEOsZhbAgj/KuRPDe1DyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A24MTvJ6r5uw1GUNxxXdaiMHY21uhpEwySTxDSzl7jIwhNmab+934QvnZT09SmkfooJbzdlM9ucausRUnvmaJvUUFU1a/g7a9i8dzC+lFQRgDRTzpxm1nQEPzreMGGEq/ygrftUKf1eHuOWeEeT9i2qJbLf+k0DF3VMQX1H36ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qygqTzKe; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36bdb11bf8bso343875a91.0
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 11:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780080303; x=1780685103; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IPBlF0ar3Vo0BpTSWk0IeaLhPGiCMkKemPuV249ODbs=;
        b=qygqTzKefO8YPcA6jt+4JU4EjuaGvOED/45Um/TXi2sWp0zJqc2ktNlyfhKsixr8jN
         WPQVQFLHKNYer3cOHecZ6IT6JoukfhVBcjdxSAxvxu6GjpBWFt05sw0A+kc74XJRJ9tf
         DN8AXKJ8FNDG79gbc3Rk3AsnCH/imkxef/X4pM5mrTBcdG2RnnrVhEAWfl20LueK2QNK
         seQ2dZy3Vjl8wOvwWGCIYQlej1Vp1ag2sWP/1bQyTi/nLbG4a5nR0ovuvqiQ22oeEmA2
         8lXBmIeo3D/IcJaZQRZgFw8645Tum/AqMR6DMLs3gGCLN3M43t4jDUPwc+1M8nosMn97
         vRuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780080303; x=1780685103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IPBlF0ar3Vo0BpTSWk0IeaLhPGiCMkKemPuV249ODbs=;
        b=ZSkEhdLqc+fozMqMuEbqHUHXUMCY5uV2/s09TemZJHzQ9dbVUg9Cfmjy02hnBS6i4P
         zwqlEUuWb43ZQEGkBZZSSGi+DLnk08n64/gS2JREf1GaJuEn3oB22Kv07F5bpmwp6KT4
         SMDgAlMHTl0SFf/Ec3Ucw1Ro3mbMAYsoqNflwgTR+BbIXgphYXm8Uklu27Qj4gbQAvgb
         d1aVL/DyPBx54sqyYqfRVd1NlJDjRpVD+rso89N9pWpWeBNgoxFQoHBfATyNwV1/GZsn
         3tz2KDt1pSjt45BxjxBB/OaXr1XsMzpzvUlzOwVqLVWyUFhgFj/F0SHZqZ5G/4UmMc1P
         dhug==
X-Forwarded-Encrypted: i=1; AFNElJ9/sCROjlcNJZjrr4A1UvIziER4PGL8bW8j+bQtUlcxobXSfC/KRltQPok8w2a+tk6W6+fHPt0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgW3oGjarN56Qq4v46F+ygxTRStjNjPtSyu8/Lg9o5qjs/GPLC
	mEF/qmHFOp4r7DFid2XWWC2Xr01SpHTKKvXYJC7n2dOHVQAKRBUfvbr3
X-Gm-Gg: Acq92OF6pViy1WBszAce8oW8cr6mOOZLcHhLaMS6rgOabnXhTqR6rBNAKERcN0osGhy
	58ISxLiEkxvwlSZTFZLH1HsygvTCUN5VyG/s6FFAmjIC2sk78myI+fBFM6uwSZCnGc55lHvrJhl
	1+EAUsClhG8AW4e+EqKTX1bFrRU5ztnuOOp5Iu/7VSbGXbzNLX0nGDqhV5M19Nb1YsH8IQRiWVn
	hFx/nr5NTbKAtknSsp5kzA5yQabK931t79mI1VxBns1AYJMAguGjSkk4wHKKp6PTYAp2NT7+ZjA
	P+041dkvl0pAOyyn6PdCJoaQUC+3sv/YOEUPHgsw/IeAujKgAL91BtXq3fNA3pvbU/2lNPcNKmB
	eb393zhvXFepBd5Dgt+5zDX7IumqxUykn7HWGM94/jAFDziuLLr/fHDlrdJ7vlz8RQmGgqAe8mw
	3qH8myGpf7Pn/ChHxlDt9/br6qjFlqIoLuDntweZpDgVdqGxchVrnH8xdpwFQqQPY3NA==
X-Received: by 2002:a17:90b:5704:b0:36b:93f7:a903 with SMTP id 98e67ed59e1d1-36c501c74f8mr417577a91.18.1780080302322;
        Fri, 29 May 2026 11:45:02 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:5e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36bc02b8b57sm3089158a91.7.2026.05.29.11.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 11:45:01 -0700 (PDT)
Date: Fri, 29 May 2026 11:44:55 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: alexanderduyck@fb.com, kernel-team@meta.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux@armlinux.org.uk, hmohsin@meta.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bobbyeshleman@meta.com
Subject: Re: [PATCH net v2] eth: fbnic: move aui and fec from fbnic_net to
 fbnic_dev
Message-ID: <ahnep1DW8kVSJcgn@devvm29614.prn0.facebook.com>
References: <20260526-fbnic-aui-change-v2-1-7c74cd48074f@meta.com>
 <20260529003714.317617-1-kuba@kernel.org>
 <20260528174507.3ae6fa6b@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528174507.3ae6fa6b@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293210-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D8589607B31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 05:45:07PM -0700, Jakub Kicinski wrote:
> On Thu, 28 May 2026 17:37:14 -0700 Jakub Kicinski wrote:
> > > @@ -15,18 +14,14 @@ static int
> > >  fbnic_mdio_read_pmd(struct fbnic_dev *fbd, int addr, int regnum)
> > >  {
> > >  	u8 aui = FBNIC_AUI_UNKNOWN;
> > > -	struct fbnic_net *fbn;
> > >  	int ret = 0;
> > >  
> > >  	/* We don't need a second PMD, just one can handle both lanes */
> > >  	if (addr)
> > >  		return 0;
> > >  
> > > -	if (fbd->netdev) {
> > > -		fbn = netdev_priv(fbd->netdev);
> > > -		if (fbn->aui < FBNIC_AUI_UNKNOWN)
> > > -			aui = fbn->aui;
> > > -	}
> > > +	if (fbd->aui < FBNIC_AUI_UNKNOWN)
> > > +		aui = fbd->aui;  
> > 
> > [Severity: High]
> > This isn't a bug introduced by this patch, but does moving aui and fec to
> > struct fbnic_dev actually prevent a use-after-free here?
> > 
> > If fbnic_mdiobus_create() registers the MDIO bus using
> > devm_mdiobus_register(), devres-managed resources are cleaned up after the
> > driver's remove callback returns.
> > 
> > If fbnic_remove() frees the fbd structure, the bus remains fully active
> > between the time the remove function finishes and the devres cleanup
> > unregisters the MDIO bus.
> > 
> > Can a concurrent sysfs access invoke MDIO read callbacks which pass fbd
> > to this function, leading to a dereference of the freed fbd pointer when
> > reading fbd->aui?
> 
> Sorry for broadening the scope here a little bit but I think we should
> fix this (as well). In the same series, but probably separate patch.
> Just don't use devm_, it creates about as many bugs as it prevents.

Sounds like a plan, I'm all for getting it right in one go.  Will revise
for next rev.

Best,
Bobby

