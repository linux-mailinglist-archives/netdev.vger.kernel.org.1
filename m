Return-Path: <netdev+bounces-33899-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2367A0953
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 17:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 359031C20FCE
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 15:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FA31CF8C;
	Thu, 14 Sep 2023 15:25:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2B139C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 15:25:51 +0000 (UTC)
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E6F41FD4;
	Thu, 14 Sep 2023 08:25:51 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-573ac2fa37aso595766eaf.3;
        Thu, 14 Sep 2023 08:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694705150; x=1695309950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VVJRtk5Aaf2CEUODsgUAPBMiRGZen6YdQG505lEua6A=;
        b=W6/qVRjhfBHmc2Nx6B2nYMA+WNq1ROIP+SEyt6KUdALMW61RwmkDTxot5w/GIdctDO
         oSGUF1aXBi7nKTZkbEzIgBmeLJchQRfIHOLawtxf7kfvrtjsvfa+7RkSYapBj1an860z
         /ri/OU3+Bq2GQzH0ELT6fENjt406cU+6+jaFeLF/bp/jyuH0OB1w9njqUG0dQtmcPyzt
         CL+LOOLGWKCHxfaOwKv1297tNM5ZvBKWDHjh0DRXSX9QdM1pmM4bPODcJy1UACd1LeJe
         iLyG4Q34W+E7RKn2iA63zlitk0x3XGPhpQz+FFO90YurLhp7B9gCNRXpkJ52oA8pUzcC
         8zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694705150; x=1695309950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VVJRtk5Aaf2CEUODsgUAPBMiRGZen6YdQG505lEua6A=;
        b=TrNzSVG2lPZlmli5epKyIhATmCqw6UCat0ahQ4cyc8tjY8tHYHKKd++m/jUtfkBVUo
         hVrQkTFZfwfZOe1XbaLTMmcSCP9pi6eZ8s2TtMjTXTl5veQ//nJiAHcKPIHSrUHqs0k0
         pwdgxXwjj7SEZ1/BLM5COZk4TSwPLnuXD/3qseO7QC2Y6x4QK5pxG6ix2YMrHGIBdUcA
         kSYbnTmuHKCnSNlFZxME/HdSnr/F/8ArXisFVpbwxe6cnoClpaZu7bpvPRbj6yIxaIMP
         fycbZTyfcNR5isPmLEjRDO/dr2BaanEYSI+ZExu+4USZbSj45g5/8B4ejQ3FNKa97Gxd
         jvQg==
X-Gm-Message-State: AOJu0YxsWR+ebXkOxE6XQqZS/tUnNHe5yB6lEynr2ouj6kc4bpacDfVM
	OrhtVC5UtGwrxzhC+WKmstg=
X-Google-Smtp-Source: AGHT+IH4U3HZ9ZIHa4b1ZVPtSgqlC3O5NGvedloge9a3e5bdCQsZhDxhiBNBDGnQ2EcwpZdJ+nW6tQ==
X-Received: by 2002:a4a:350c:0:b0:571:1a1d:f230 with SMTP id l12-20020a4a350c000000b005711a1df230mr6587755ooa.9.1694705150278;
        Thu, 14 Sep 2023 08:25:50 -0700 (PDT)
Received: from t14s.localdomain ([177.92.49.166])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d74d4000000b006b74bea76c0sm767215otl.47.2023.09.14.08.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 08:25:48 -0700 (PDT)
Received: by t14s.localdomain (Postfix, from userid 1000)
	id 037BD76E474; Thu, 14 Sep 2023 12:25:45 -0300 (-03)
Date: Thu, 14 Sep 2023 12:25:45 -0300
From: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
To: syzbot <syzbot+00f1a932d27258b183e7@syzkaller.appspotmail.com>
Cc: bp@alien8.de, brauner@kernel.org, dave.hansen@linux.intel.com, 
	hpa@zytor.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-sctp@vger.kernel.org, lucien.xin@gmail.com, mingo@redhat.com, netdev@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	x86@kernel.org
Subject: Re: [syzbot] [sctp?] [reiserfs?] KMSAN: uninit-value in __schedule
 (4)
Message-ID: <cbakbuszcnwtfkdavtif3lwfncelm2ugn6eyd5pd5dmdocxqh5@3op6br7uaxd7>
References: <0000000000007285dd0604a053db@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0000000000007285dd0604a053db@google.com>

On Tue, Sep 05, 2023 at 10:55:01AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a47fc304d2b6 Add linux-next specific files for 20230831
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=131da298680000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=6ecd2a74f20953b9
> dashboard link: https://syzkaller.appspot.com/bug?extid=00f1a932d27258b183e7
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116e5fcba80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=118e912fa80000

Not sure why sctp got tagged here. I could not find anything network
related on this reproducer or console output.

  Marcelo

