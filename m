Return-Path: <netdev+bounces-108475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE21D923F0E
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 15:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 04901B28E38
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 13:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D23791B4C3E;
	Tue,  2 Jul 2024 13:33:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEAC15B109
	for <netdev@vger.kernel.org>; Tue,  2 Jul 2024 13:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719927188; cv=none; b=csLHHNGmrbGeha5qc+jA6CThP0WPdxkRTBZmXpTO8SFb1gf78HNXzLrS5eWSVI+VNx5eHwMHrWuaFCgYJIO2UiZ0xoJNOuP5cINxrjNahf0lua61ESHJS1Cb4kdSaCkRBEpD8B0LL/zGHM/f0rGG+trjporECF3xn6PIXd6Jg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719927188; c=relaxed/simple;
	bh=ywPKyRVwQw51zU0gYtKM3uvW1vgxSjcsF8zR/5RYUfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XyuV3vBS0KiRiUimEFzBDUSnWuQ8JUWrurKRy0zwbaHQTFGpggsAFfDDk7Wx4Pg2SrNJyCjauuDOFPQpX2figy2WEq0JyMwIKgs5wg1gm6BijJX2zIX26IBBKizNgGdTsJGwx8y7IY++QK7hrK8N6mm4vyT70DGm+B7gzs50VeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-58ba3e37feeso843634a12.3
        for <netdev@vger.kernel.org>; Tue, 02 Jul 2024 06:33:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719927185; x=1720531985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOkvdQtYmcqAXVFGO+c6RVoHQeZLdjxmxpP1HWTNTBU=;
        b=A2IvxDZgfLTwLq3ozl63F3CFdBR9SYq0+NfGM4vOIs89qWLvp6UTQivxtmWeHgzxln
         ZwSLI+/gJhUh9B9GgO0Q3butGRWLGjYyJpm0eb29cqwUXa26dDa1pvuevaF9oZ2vxKYz
         Wz7sMjcdGu9eWkVB37LdFhnz+dEeDH7z7PVywiRptPjMe0adAJMucUihp3oWFGG3wV25
         cRns0IoJDH8qxqvT+ToOaLJXpzRdCgo0er+d+FmL+tlp+LH5zNhf9q0YDselcP0hzu3e
         HlpdRtmga/WADD1woLHRYrea5kZxRBUKElWxrOnbPwQpkDdbSCf2//y/i7eBtgYdw3j8
         5+Yw==
X-Forwarded-Encrypted: i=1; AJvYcCW394R2WDNhMqyU7wsS0kDxotWlhM4dINf0XnziuEqMxvlu8rjGVdjzbiwV73vYms4ro81Um1beL7N/6Qhh6xozblvVQKyl
X-Gm-Message-State: AOJu0Yx0FcFV06k0D8nAdxT3VUvIANyT+0/Va88PIjxNO/gDDkXaTtfc
	qFucKUTOHnIgAad7CMSuRcI09aTTlI9yIYl09ghFyyeTvvxTnbVn
X-Google-Smtp-Source: AGHT+IFMraYu2aPoIooLadmuA03EaJnzyv4zAh2e17tIjIYQudbaWZBo6EOFt7y8sosj3E7OdYQHRQ==
X-Received: by 2002:a17:906:ca41:b0:a6f:5c1a:c9a6 with SMTP id a640c23a62f3a-a7514441505mr563250166b.62.1719927185331;
        Tue, 02 Jul 2024 06:33:05 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab0b84e0sm423799466b.210.2024.07.02.06.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 06:33:04 -0700 (PDT)
Date: Tue, 2 Jul 2024 06:32:37 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	netdev@vger.kernel.org,
	Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
	Pankaj Gupta <pankaj.gupta@nxp.com>,
	Gaurav Jain <gaurav.jain@nxp.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 3/4] crypto: caam: Unembed net_dev structure from qi
Message-ID: <ZoQBdcpaI4q9Fj3r@gmail.com>
References: <20240624162128.1665620-1-leitao@debian.org>
 <20240624162128.1665620-3-leitao@debian.org>
 <20240628163226.GJ783093@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240628163226.GJ783093@kernel.org>

Hello Simon,

On Fri, Jun 28, 2024 at 05:32:26PM +0100, Simon Horman wrote:
> On Mon, Jun 24, 2024 at 09:21:21AM -0700, Breno Leitao wrote:

> > @@ -530,6 +530,7 @@ static void caam_qi_shutdown(void *data)
> >  
> >  		if (kill_fq(qidev, per_cpu(pcpu_qipriv.rsp_fq, i)))
> >  			dev_err(qidev, "Rsp FQ kill failed, cpu: %d\n", i);
> > +		free_netdev(pcpu_qipriv.net_dev);

> Hi Breno,
> 
> I don't think you can access pcpu_qipriv.net_dev like this,
> as pcpu_qipriv is a per-cpu variable. Perhaps this?
> 
> 	free_netdev(per_cpu(pcpu_qipriv.net_dev, i));

You are absolutely correct. Let me fix it.

> Flagged by Sparse.

Thanks. I've just added sparse to my development workflow, and I can see
it also:

	drivers/crypto/caam/qi.c:533:29: warning: dereference of noderef expression

Thanks for the review. I will send an updated version.

--breno

