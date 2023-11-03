Return-Path: <netdev+bounces-45993-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5908F7E0C0F
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8962F1C209D9
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 23:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E970C250E9;
	Fri,  3 Nov 2023 23:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ERIPyEnC"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658BE249F6
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 23:18:49 +0000 (UTC)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D745D5A;
	Fri,  3 Nov 2023 16:18:48 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bcef66f9caso553793b3a.0;
        Fri, 03 Nov 2023 16:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053527; x=1699658327; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EUmRHvTQc1DzXbF2Te1K0K+hGK6pEUjIwadabL+ZWL0=;
        b=ERIPyEnCh0JAWgUhr3LH5Yl06w2QGJSjKWkMefkrqT6BLwKgrj3T49xPbZVTuh89ud
         OQsBxPXDD0vbBZamvz9Qo+T4Yj0YpSzkKPe+vV0AfXXvfSI9lJDibnpxTPC8HAdNKjfr
         f/DR6aAGoTOd1izypmkyiQf2Iiw7ZL9KcK099WmGCPoH3tYuqCOiI66vGk5zZ1cG2WBE
         vm7xN1XynN/9uCnAeoUeTZaXEGeWlh8Q7a1KF4QAWwO4ogOMXbnUbPgOAferfs6Sq+wK
         AZ/pGoCT9BfpxzCzSlRZSfz2lebomRXu7pJjDKL1Za5OQjYOtF1gFPdS/p5hGdKgIcUR
         Kaog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053527; x=1699658327;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUmRHvTQc1DzXbF2Te1K0K+hGK6pEUjIwadabL+ZWL0=;
        b=ernqL2vmOJbYnLiJqTPy5ehD34vavYiw6RkDyS+CsIY7M183ic1tMbXDJ7TI5EKIHh
         BqJCwL7QHBAoOYBmVqyfNloPqzyRlXwG4d4jx2nscnzLWSMPCak3xwGizgplezQKei7g
         ITGpfUA0iD6gma2wUE0iWMl6Cz83eEaWT2PCAOGIDVRftAS199WiR/0n5UEl3ljeq9x5
         qgYVODasJnyI9PEe8OJY26miG6h4JeYYLKiJyKEqgsqR00nZkZxWEe0DxnsE1/9QacKg
         mFgEQfbfDFFQ4i4ZTTjH6hPbrfBIKCX9K2cGCnRcwhN8aNAo7XXV2dn0mivUEy9rJXXR
         uHpg==
X-Gm-Message-State: AOJu0YzgdMlgcaFiZL1CUyLWKvQ0QKJxqoAS8n5vL3MLvEoTIWBxdR/J
	UQ66PkE1Ed5gDhcFy8HT3mo=
X-Google-Smtp-Source: AGHT+IHicUMdnVfm2WasDY3icooZua+bYT643mqOC+1cA4aWr/7FDqm+0ElhfQebLCHsNbuXSo51zA==
X-Received: by 2002:a05:6a00:468e:b0:6c0:81a3:fe4c with SMTP id de14-20020a056a00468e00b006c081a3fe4cmr24831172pfb.3.1699053527619;
        Fri, 03 Nov 2023 16:18:47 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id y11-20020a62f24b000000b006c067f1b254sm1880560pfl.122.2023.11.03.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:18:47 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:18:44 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>

On Fri, Nov 03, 2023 at 09:15:03PM +0800, Edward Adam Davis wrote:
> There is no lock protection when writing ptp->tsevqs in ptp_open(),
> ptp_release(), which can cause data corruption, use mutex lock to avoid this
> issue.

The problem is the bogus call to ptp_release() in ptp_read().

Just delete that.

No need for another mutex.

Thanks,
Richard

