Return-Path: <netdev+bounces-60098-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFB681D539
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 18:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE9E1C2112B
	for <lists+netdev@lfdr.de>; Sat, 23 Dec 2023 17:17:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A70110A14;
	Sat, 23 Dec 2023 17:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="QkHt9b8m"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91175208C0
	for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 17:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1d3e05abcaeso17138445ad.1
        for <netdev@vger.kernel.org>; Sat, 23 Dec 2023 09:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1703351820; x=1703956620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cNloK2zmpSI/pe5rFD+LQ8j7TbMA6oNjqdHHE0gWF4=;
        b=QkHt9b8m9YO74zc1F5bKM8QTnUddPdh2/K8428TPC7/W5IxTAlkqZwTvtmuk4rqDu/
         mxnU60cNJp4yh3s3CJjMGfTcT/rOHcexmAw+hGEGdm+bL/W4Equw7izNppI8j2NBATeL
         NNwiy3UP3X0SBQrUdgsmjJHVSdiMFxACXQkhZ0YV05dqa3zXvkWuLp3hLggvApE02JVc
         414Zzs2IXOzUGyc3PeKlahtQUMTO6w78Cr20OpKps+oh8C2HFQxmoLHet7MK/DECoWgs
         Nbmd0qwzu37dInwAv4APFsW9BbCsghO8EYcH9ZVrr3eVJ/Ez7Uc6J9XDQyWJ3uXJJYkA
         Z/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703351820; x=1703956620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cNloK2zmpSI/pe5rFD+LQ8j7TbMA6oNjqdHHE0gWF4=;
        b=OFpFfAJwQ0JH+qYBBWHyylJlci532nd6657uQMFRfxunWVwG7mBBW4GCg4F76j6yY2
         ZVXDG5iNiqA3CKZdqsdI/PSXWFHkheOjzwXpUolntZP61QDz1Aab0blwuXZe/mSltLIs
         b5pqU3TN1c55hKcEHmAITij9MdYMg6yD0zCcKlEARad8j6DYI0HpHFyFETGppvOvQlZu
         cXlsB8ktOrBsd9yNPVosOKD8Lue9U+gpMGe7KEphNGBvR+ucXwM53PUGRTKWRc7Bp0SX
         OTO6apJIWKM2XIPvOa1p2pHk8rUlxC1WPOkjMP2v6dEGhZlmy7JeAY5ZhIxMzGFsx9SA
         OBXw==
X-Gm-Message-State: AOJu0Yzo+VA8Zl+NnIgH6zbfr+/lZx3RJPxgbvAF82xUYQKzgSDkIoH5
	+wBH8+kiyY03GV/Y3QoNS3GlZcE3yXlkLdjLDr1IYd73+wtb3g==
X-Google-Smtp-Source: AGHT+IETlOW+t5TZx2HLceDyDeUBp+Lh0734HBd2Yhg12Nq9skzAKYWxQ0erCmv0QhOW/WOchQuuxw==
X-Received: by 2002:a17:902:dacd:b0:1d4:2d8d:3545 with SMTP id q13-20020a170902dacd00b001d42d8d3545mr1094558plx.71.1703351819847;
        Sat, 23 Dec 2023 09:16:59 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id n7-20020a170902e54700b001d38a7e6a30sm5309216plf.70.2023.12.23.09.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 09:16:59 -0800 (PST)
Date: Sat, 23 Dec 2023 09:16:57 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, xiyou.wangcong@gmail.com,
 netdev@vger.kernel.org, dsahern@gmail.com, pctammela@mojatatu.com,
 victor@mojatatu.com
Subject: Re: [PATCH net-next 1/5] net/sched: Remove uapi support for rsvp
 classifier
Message-ID: <20231223091657.498a1595@hermes.local>
In-Reply-To: <20231223140154.1319084-2-jhs@mojatatu.com>
References: <20231223140154.1319084-1-jhs@mojatatu.com>
	<20231223140154.1319084-2-jhs@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 23 Dec 2023 09:01:50 -0500
Jamal Hadi Salim <jhs@mojatatu.com> wrote:

> diff --git a/tools/include/uapi/linux/pkt_cls.h b/tools/include/uapi/linux/pkt_cls.h
> index 3faee0199a9b..82eccb6a4994 100644
> --- a/tools/include/uapi/linux/pkt_cls.h
> +++ b/tools/include/uapi/linux/pkt_cls.h
> @@ -204,37 +204,6 @@ struct tc_u32_pcnt {
>  

Seems like a mistake for kernel source tree to include two copies of same file.
Shouldn't there be an automated make rule to update?

