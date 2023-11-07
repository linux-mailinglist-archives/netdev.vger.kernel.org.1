Return-Path: <netdev+bounces-46351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBB57E3517
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 07:13:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 878D8280EE6
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 06:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3E8F7A;
	Tue,  7 Nov 2023 06:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EX/9QLC4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9730C6AA0
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 06:13:06 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FD6410F;
	Mon,  6 Nov 2023 22:13:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6bd20c30831so974946b3a.1;
        Mon, 06 Nov 2023 22:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699337585; x=1699942385; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eYDdK5bxPox1XDZTxjW6zzD5nW+jVYa/FuFqSU8icUM=;
        b=EX/9QLC4rkeRsgc+c2OqF6gYkQH43wBqJWbx46oKQtTaRsdiNY99+0/In00/AtLbI8
         CoGcFeEc65+ZGD4YL42CFa4G0VH0ZJ3/u/43yePBGhn9/TbCGO3fbcqnpAXxsKp8a2/2
         h1Gs7iqDxg/OZAs6Q2OTGjKeu2gslBsa6IL437LX/aA8asuCqmyuILCqUVQ+B/5XQY6L
         OGPRABhHgc8rTh4/FFfTgDGLbrisSRM8MhZ/LW0ZIbnnVDL9E4o8NsU/cq8hYVLCZ3au
         uCECtUXznuhEp7VyTphJR0cuBZ5zAED8KT7lOHPEHfDMUF1ZYGdMu4FI8I9kKDqCsqRP
         oyIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699337585; x=1699942385;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eYDdK5bxPox1XDZTxjW6zzD5nW+jVYa/FuFqSU8icUM=;
        b=VMoWNMPnjKvE0BkB1z11pqBUf/jBPhk28ZPoJfjUO8Y19fudCOj7fZif2+8fsbTDDu
         jdAIWgCzdH5IIztAIefAir7hp12+yGT28E+8Pw5JVCgxRuHylebsAUIT+Y8GnB9ZQZIl
         jGgAjq/EZIFZndJ4oBFBHmjcV6zdaJVbSSrSf3zDUHHEH2UZ5N1zOcLJWwvScp8DajGo
         4EJT+WfOocUeuSoCPIvM8odmmtZllctr4SSx97aAQ1mpt9lm7arEC4wEIhuK0mqaTDAu
         PhX1W60WG2h5sM0TURQukqjXUPsYgo8F5hJahllp8Gj/KtoHBw3BaabIL/8wl8JePXm+
         ozoQ==
X-Gm-Message-State: AOJu0YzmfpSgbjAZtOo2EQ0wqFFKRmoNt4LN9gr/ttwmQ/CuPrStM8xw
	cD0YBhS8KUukopiJsu0J1c0=
X-Google-Smtp-Source: AGHT+IGHq3RsTsOApBXXHfRMGdLm3/XmlgmQt2GrdztgBlzcj6/WtoF+2EeTCPS5SL3OYPSU3f///g==
X-Received: by 2002:a05:6a00:309b:b0:6b9:7d5c:bb58 with SMTP id bh27-20020a056a00309b00b006b97d5cbb58mr29937251pfb.0.1699337584912;
        Mon, 06 Nov 2023 22:13:04 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id bd32-20020a056a0027a000b006870ed427b2sm6626300pfb.94.2023.11.06.22.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 22:13:04 -0800 (PST)
Date: Mon, 6 Nov 2023 22:13:02 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, habetsm.xilinx@gmail.com, jeremy@jcline.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V8 1/2] ptp: ptp_read should not release queue
Message-ID: <ZUnVbk-1Y-Yxq5ik@hoboy.vegasvil.org>
References: <tencent_AD33049E711B744BDD1B3225A1BA3DBB9A08@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_AD33049E711B744BDD1B3225A1BA3DBB9A08@qq.com>

On Mon, Nov 06, 2023 at 10:31:27PM +0800, Edward Adam Davis wrote:
> Firstly, queue is not the memory allocated in ptp_read;
> Secondly, other processes may block at ptp_read and wait for conditions to be
> met to perform read operations.
> 
> Reported-and-tested-by: syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
> Fixes: 8f5de6fb2453 ("ptp: support multiple timestamp event readers")
> Signed-off-by: Edward Adam Davis <eadavis@qq.com>

(This should go to net and not net-next.)

Acked-by: Richard Cochran <richardcochran@gmail.com>

