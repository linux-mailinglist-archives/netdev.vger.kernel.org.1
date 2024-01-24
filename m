Return-Path: <netdev+bounces-65417-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D42ED83A692
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 11:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133C61C211F3
	for <lists+netdev@lfdr.de>; Wed, 24 Jan 2024 10:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB89F18C3B;
	Wed, 24 Jan 2024 10:18:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 351DE18C01
	for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 10:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706091522; cv=none; b=ou8JGtN0UiLkOY0PQ9RZ8FZlI4m16BNLX8EXC8uHa/xX7RMuonVpDB9MUZkB8IAYb8s2PuIcTXPDNb1Gr3oVvlKzrg6/+mc5nTNj6X/tXVomGd+wgSxQgHNacJxXEQSC5ksa6cSWzzfTjeg8CwYhxgfrFUtc8UzGVAWQY3yk5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706091522; c=relaxed/simple;
	bh=9+OY4PAWIzRZs7UzVJYwMvFtiA3A4QkSzq1p+PAXIwU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oDnUb3Z2pFbOSB0andFEpOzJEF67VOKW0SfmU1Rm2PYCFl4tApoQveU4mkb9WFi3wqRdDw3Xe5GziW63op7QHkfHgyVoHHhC1KXoJMTu3ip5FImx6KbbOhK6FfnnyR4ufxeZWcztVaQ6ORnhqVyLtdG+4Ppd5udOg+7Rp2pp6Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50eabbc3dccso6623968e87.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 02:18:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706091519; x=1706696319;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CbltCbFre5N0OQzMouEtuc/J0hmDrG82Bva39iCATdo=;
        b=uTjZdXhgw4A0w1NKVOt1swqn41X6Rtqb8wtZswiOdNxwWHTVCswnNlJygbik6CqWOu
         Mk4piRDG1c+aqCbof0R6iPTe864HK2UwYYquuAsfFR103snIPPf+LUSRmA4Yv2y389gR
         j9YIRE++Ld+8lwJ3kJVBi6Q2nsiDzoheN9lzFeMg/3FcH/yDAcf8/gsn/7l5nv1HqeTu
         tpnqNzUM03HtEj70QmfFU3d7fkT5fOtG+WpF5oAJds1s1wc9N38nAm5yZofywkJeuat0
         B2ye+4UIJRSCKLoPWewEDE2rOwrnyOoLn5RMjyjES3aCuyp1K1WZwavpld5SthdeyfQ2
         zHtw==
X-Gm-Message-State: AOJu0Yz+Iiu4/9Ge5G3aW2KFobAlU/kVVGXiKBvVXiyL6mWwJ4+pPcpO
	tbnW471ycAz5am5IBpebpLPfKItwUvkC2nJFAoRDv1IvCg5Fob3N
X-Google-Smtp-Source: AGHT+IGRPJ4LJJn2rrCbgBiuN6e4c4t+HXTgH3ZQ6uhWCYzwge80+GHDwvKkEUIVAcOYnWhPMd8KmA==
X-Received: by 2002:a05:6512:1082:b0:50f:1e53:d537 with SMTP id j2-20020a056512108200b0050f1e53d537mr1947957lfg.77.1706091518959;
        Wed, 24 Jan 2024 02:18:38 -0800 (PST)
Received: from gmail.com (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id th7-20020a1709078e0700b00a2fd84bc421sm4431198ejc.83.2024.01.24.02.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 02:18:38 -0800 (PST)
Date: Wed, 24 Jan 2024 02:18:36 -0800
From: Breno Leitao <leitao@debian.org>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: Re: [PATCH net-next 13/13] bnxt_en: Make PTP TX timestamp HWRM query
 silent
Message-ID: <ZbDj/FI4EJezcfd1@gmail.com>
References: <20231212005122.2401-1-michael.chan@broadcom.com>
 <20231212005122.2401-14-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212005122.2401-14-michael.chan@broadcom.com>

Hello Michael, Pavan,

On Mon, Dec 11, 2023 at 04:51:22PM -0800, Michael Chan wrote:
> From: Pavan Chebbi <pavan.chebbi@broadcom.com>
> 
> In a busy network, especially with flow control enabled, we may
> experience timestamp query failures fairly regularly. After a while,
> dmesg may be flooded with timestamp query failure error messages.
> 
> Silence the error message from the low level hwrm function that
> sends the firmware message.  Change netdev_err() to netdev_WARN_ONCE()
> if this FW call ever fails.

This is starting to cause a warning now, which is not ideal, because
this error-now-warning happens quite frequently in Meta's fleet.

At the same time, we want to have our kernels running warninglessly.
Moreover, the call stack displayed by the warning doesn't seem to be
quite useful and doees not help to investigate "the problem", I _think_.

Is it OK to move it back to error, something as:

-	netdev_WARN_ONCE(bp->dev,
+	netdev_err_once(bp->dev,
			 "TS query for TX timer failed rc = %x\n", rc);

Thank you

