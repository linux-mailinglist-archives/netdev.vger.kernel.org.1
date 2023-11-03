Return-Path: <netdev+bounces-45996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA1C87E0C2E
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:24:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA12D1C209D4
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 23:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E353025113;
	Fri,  3 Nov 2023 23:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lT3Dhm7A"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AEA1F601
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 23:24:53 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8129A2;
	Fri,  3 Nov 2023 16:24:51 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2800db61af7so670789a91.0;
        Fri, 03 Nov 2023 16:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053891; x=1699658691; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1u5m6dlQXf6Wo/EeO3f8wkZCknJ2zjID8Vb7+EIy4Nc=;
        b=lT3Dhm7AwolRs7E1GIYht3QaAuGAP1YPXz6DQpqc48ss8oQCh5vwOUV+XaNmep3aYG
         1k4V2AnAmV3XNx4AVafZoGkazCPacouc87ePcekULi/MKgDFYxRZUyRbL9j4p7e2lxuj
         YOKRZAk0Z5AZsjkffhmQD+ALKNSAyFPRQo4Vc8/oRtoDC8YzazL/tO45SIvEKMFY0Wrv
         dfmzB7BmGY113TKGu/Jedv/QOVXzvTYxeDjGyAz0Ou/9jiPNqHtv0qvYmkJMN7+rWwel
         Sde7IRaanS/zYe0IV5eb10M+qfiSdnO75hX34numZWkHdBWjyPiGmNg2FAxTRvp7WEZ8
         ajMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053891; x=1699658691;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1u5m6dlQXf6Wo/EeO3f8wkZCknJ2zjID8Vb7+EIy4Nc=;
        b=uJmBVwZC743FYx9sDq/iRRU1YBy+JmpX54c09O+mzddbozZFz6yDqviKN3V3taq0nu
         xkTDujGW4XNaPWiNGvXauAJLz2DYw/4306lJIyfru36kNzArB3lSS+3otcaoWee2IwRY
         fhIV5lWrMZISX+lPYBOVujSTYaEvmjLmiMqd8T1QikkaEeIcYb4B4PIweGVSPvoAm3nS
         LIVOPQ4QPepC6sS/jkUUIDyn4EKalG+5oag5sRYIyfL/j/1KtG9+IG50YpQU93NzuOHS
         5gOr5QPWHpaR/vW2C1ZfdO9urV1FDh4tBXhydKM74vbObWCNc1xy3JRofgP0f+3qNJ1C
         F8+Q==
X-Gm-Message-State: AOJu0Yxs3XL3mgOI6AvWUusgugik500D8BjS8RKpf59HGB1xgNylQ56j
	Uy6L6/BmfdpMvMr9Pc6/tco=
X-Google-Smtp-Source: AGHT+IEEZtMYlk0JPMSDzLWF9UGamGEv/PI/eyLfuAHH+bMh2n6k9oJ+4aKZ8t1rRgg+OWOQJoI3vQ==
X-Received: by 2002:a05:6a21:a59d:b0:163:d382:ba84 with SMTP id gd29-20020a056a21a59d00b00163d382ba84mr28833842pzc.5.1699053891063;
        Fri, 03 Nov 2023 16:24:51 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id u22-20020a056a00159600b00687fcb1e609sm1890574pfk.116.2023.11.03.16.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:24:50 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:24:48 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: jeremy@jcline.org, davem@davemloft.net, habetsm.xilinx@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com
Subject: Re: [PATCH net-next V3] ptp: fix corrupted list in ptp_open
Message-ID: <ZUWBQE7vfBXAVADq@hoboy.vegasvil.org>
References: <tencent_97D1BA12BBF933129EC01B1D4BB71BE92508@qq.com>
 <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZUV_1CZRUQTiANTT@hoboy.vegasvil.org>

On Fri, Nov 03, 2023 at 04:18:44PM -0700, Richard Cochran wrote:
> On Fri, Nov 03, 2023 at 09:15:03PM +0800, Edward Adam Davis wrote:
> > There is no lock protection when writing ptp->tsevqs in ptp_open(),
> > ptp_release(), which can cause data corruption, use mutex lock to avoid this
> > issue.
> 
> The problem is the bogus call to ptp_release() in ptp_read().
> 
> Just delete that.

Like this...

diff --git a/drivers/ptp/ptp_chardev.c b/drivers/ptp/ptp_chardev.c
index 282cd7d24077..27c1ef493617 100644
--- a/drivers/ptp/ptp_chardev.c
+++ b/drivers/ptp/ptp_chardev.c
@@ -585,7 +585,5 @@ ssize_t ptp_read(struct posix_clock_context *pccontext, uint rdflags,
 free_event:
 	kfree(event);
 exit:
-	if (result < 0)
-		ptp_release(pccontext);
 	return result;
 }

