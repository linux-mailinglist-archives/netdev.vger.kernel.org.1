Return-Path: <netdev+bounces-45992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20B317E0C07
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 00:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26BB21C20A0D
	for <lists+netdev@lfdr.de>; Fri,  3 Nov 2023 23:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B48250ED;
	Fri,  3 Nov 2023 23:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBlEGJKz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145524A05
	for <netdev@vger.kernel.org>; Fri,  3 Nov 2023 23:15:27 +0000 (UTC)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817DFD75;
	Fri,  3 Nov 2023 16:15:24 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2802a827723so595400a91.0;
        Fri, 03 Nov 2023 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699053324; x=1699658124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eUbuLZZiiMqt8h7niCAP5iYDjZ6kaMpEpgDdEjnpTaA=;
        b=VBlEGJKzKs2T58Oqtw5ATxpwlkGQaaqRMA8UkxMzJRYIYTSA2Tj48iSxK0adWbVyfv
         lCuipHW0G8mx/0vx4+wr0dVzb7JFyGqwbmSU9Uud6rdcbTkelQ0YbhATRVnGj5c18PRN
         PEgHyncnBcAGqMwmBTuxs1lSdNnoaqxuqIYbDwAfkESluH5kKKUm5Rya2r4VhJrYmU67
         BckPZqliEQ3JUg/Jvok/YjMWbgZ1Xg64GVJGCHg/4LWLF2sZEdmUn6Dtc4Vr75phedaw
         dpl4tRLzJZUcUmqXSsPli6MYdRBoFACRQAzVZanPFM/VsqOe8N1xiKe/ik4WiOFTAQCj
         XKWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699053324; x=1699658124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUbuLZZiiMqt8h7niCAP5iYDjZ6kaMpEpgDdEjnpTaA=;
        b=QRsiQodLqkQZZ5e3F62RGNVtpl0KL/No7hynC5frM/erLvkov5jeEQRc0lniFIAR+m
         HW8Yi+WaD8JMKN6eO7zEt3wUWalCtg3QUd2bvnz7Gm87dSmScgUJ8jQ45sD6gKcnlAy3
         kpYRBLNC3MiRJl+PV7dI+xBojhfupKK/jZl7ugqzQ5jFyXzZZ3jCLckLgg+NIMY5MEjv
         ylBTwob2cAhx7btTiHHqwJc8eEW3lBkfW0NJgKtzfv0NCPdhKGpXebkKNnlmfhOuOLK8
         ucs1I3mqwh30DnC817tV391KA7sFZqMm12SmnLqSqWrI3NX07hhzT75ECs/AhIo6g9Gl
         HQww==
X-Gm-Message-State: AOJu0YwJrwSxIRSlMbj1QYsAkXnbNG/0janJvI7ngcH8A1DuUl15MgCT
	+iFHXiLfD1PUMYn6uDcnqqw=
X-Google-Smtp-Source: AGHT+IFGSdagiS8UoA75QxW/N8+9LLInHQ7sVrQMtQNdJWWK7/gq+5dm71BtD8OH8bjmeeu+HLWrHA==
X-Received: by 2002:a17:902:e2d4:b0:1c9:e121:ccc1 with SMTP id l20-20020a170902e2d400b001c9e121ccc1mr23406449plc.5.1699053323839;
        Fri, 03 Nov 2023 16:15:23 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 1-20020a170902c10100b001bde6fa0a39sm1858100pli.167.2023.11.03.16.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 16:15:23 -0700 (PDT)
Date: Fri, 3 Nov 2023 16:15:21 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Edward Adam Davis <eadavis@qq.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, reibax@gmail.com,
	syzbot+df3f3ef31f60781fa911@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH net-next V2] ptp: fix corrupted list in ptp_open
Message-ID: <ZUV_CYndqqdt4aY9@hoboy.vegasvil.org>
References: <ZULphe-5N0M5x_Kk@hoboy.vegasvil.org>
 <tencent_ACEACCAC786A6F282DF16DCC95C8E852ED0A@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_ACEACCAC786A6F282DF16DCC95C8E852ED0A@qq.com>

On Thu, Nov 02, 2023 at 07:16:17PM +0800, Edward Adam Davis wrote:
> The above two logs can clearly indicate that there is corruption when 
> executing the operation of writing ptp->tsevqs in ptp_open() and ptp_release().

So just remove the bogus call to ptp_release.

Thanks,
Richard

