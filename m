Return-Path: <netdev+bounces-45100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C93117DAE14
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 20:57:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 056A01C208F5
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 19:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FE1910961;
	Sun, 29 Oct 2023 19:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dnWAGqif"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216B4C2DF
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 19:57:32 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB1CFBD;
	Sun, 29 Oct 2023 12:57:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9cc6c92d1e9so106572066b.1;
        Sun, 29 Oct 2023 12:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698609450; x=1699214250; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vx7izOau8sCiVgG0u6aOBpYUrdCuQ45nTL6cseN6K0E=;
        b=dnWAGqifrEk/k6HKoxIoUgPoTiA3KmVHVxO8X+4awEitBgSBLj1VC7nTg+gdeQqnqC
         zzGmoTKFXNYlhoRlPmtBi67r9n4T5UCzRNGJiY/YjtFYeQuS3wkOs9tOk/MnKm3yFGt3
         4oJ3totMJvIlmTujbgu/Bam4+QKv9tvAPofKNeqzOd9hg+ObWwv/I8yLmQY3Qy0VoAlX
         RaAmWm5S1Uo/p0/udFhm6XtDHyjZzBj38IJdSILbZLMZHaECN4m0sBtrl/HJcDp6/RKD
         BN1MoC6URu1n4iXMdwj4dvlmR3s3Yd5XPJa9Tf1x5yn8AhLd7gbC5mhVlpwAx1/eZsGD
         W3Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698609450; x=1699214250;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vx7izOau8sCiVgG0u6aOBpYUrdCuQ45nTL6cseN6K0E=;
        b=bJ9t6sc/agcFVrCO/+SX6cObXzyOKQX1N+WG+Wqa5wKXK6weLA7iLpa/8eJhC2c3Sf
         3TTmlz+2f9KbWSu92dvJ8bw22PwLf5vqLiCFlVmNQOC+4TBIXMOQQC30W7Ey3iaFud52
         Q6ZOml1A2pz8xuEzpAg8tbJw7fgmXgMpvcNyBQqVoh53YwtDjiBu89e5GukgXvZXxEtQ
         VnFJ8tLAypaMIU0fpqmlaFYX+eW+V/do2PBOBNY5dJeilJagC+AGkGrGZMw/ZirCjHRG
         NqCOjrSsjXk7dEypbMMw2wO+pJw0NYU+3aU5ou8dqNrEk/cU7NwGUSxknHO6FHQ1Hxow
         m3DA==
X-Gm-Message-State: AOJu0Yx42CKXY41Qqxcd/DEgw5OSQs7SHu1iGRnFqctIjr1qU0KBuYeJ
	QFIiJSxRGM3m4F3KCSYu0q4=
X-Google-Smtp-Source: AGHT+IF/H3xSwOkvHLMT4GIJk/7IShD1YiuOAyywwIAOxmeQfdO2wz65jC3sWyupsmOjPUG/bODFZQ==
X-Received: by 2002:a17:907:890:b0:9d0:51d4:4d7f with SMTP id zt16-20020a170907089000b009d051d44d7fmr3940052ejb.1.1698609449967;
        Sun, 29 Oct 2023 12:57:29 -0700 (PDT)
Received: from hoboy.vegasvil.org ([88.117.214.186])
        by smtp.gmail.com with ESMTPSA id j21-20020a170906051500b009b2ca104988sm4828423eja.98.2023.10.29.12.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 12:57:29 -0700 (PDT)
Date: Sun, 29 Oct 2023 12:57:27 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH-net-next] ptp: fix corrupted list in ptp_open
Message-ID: <ZT65J4mvFe1yx5_3@hoboy.vegasvil.org>
References: <tencent_61372097D036524ACC74E176DF66043C2309@qq.com>
 <tencent_D71CEB16EC1ECD0879366E9C2E216FBC950A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_D71CEB16EC1ECD0879366E9C2E216FBC950A@qq.com>

On Sun, Oct 29, 2023 at 10:09:42AM +0800, Edward Adam Davis wrote:

> @@ -585,7 +596,6 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
>  free_event:
>  	kfree(event);
>  exit:
> -	if (result < 0)
> -		ptp_release(pccontext);
> +	mutex_unlock(&ptp->tsevq_mux);
>  	return result;
>  }

This is the only hunk that makes sense.  Keep this, but remove the
rest, just like in your previous patches.

Thanks,
Richard

