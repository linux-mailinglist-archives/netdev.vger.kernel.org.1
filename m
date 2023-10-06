Return-Path: <netdev+bounces-38467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF907BB11A
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 07:11:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C30751C203AB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 05:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24D3C29;
	Fri,  6 Oct 2023 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="msxX8KeJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA81EA1
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 05:11:10 +0000 (UTC)
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12855B6;
	Thu,  5 Oct 2023 22:11:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-2773b10bd05so403218a91.0;
        Thu, 05 Oct 2023 22:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696569065; x=1697173865; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2wogXvWcArLn5DTPgANPEr01Ke4o8oj2hux7vDZifBg=;
        b=msxX8KeJ2Jc8z/YmuDeC7+QfOnoxzCm/9WtOn8Bfv0WglBkohPfV8mydTZ026evj76
         2Yf79833/5oLHqPKXgK/iMoWgMb69pUKGA/7SIhb3rA/bT0OA8GU3lnTWZlX/O/VHtFA
         PcMWrBZIaslL/Uwx05G0y4L+iS+IcbAcaAFY9E22695Okwc+2OvhDVe7LgwRSI2LZJ4w
         PnxKyjMbuWayVolfiJh+7S/NN9G6XZ5ub2X3WO/p2s68kgJXaFNH09nJ2l4stmeuS39R
         FiARz8hdWR9nVz67WjkrnfC+yRW1fEsKCFWBSnYJH/6f1dNSN/6CQHyd6jgetWHfdVZC
         gDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696569065; x=1697173865;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wogXvWcArLn5DTPgANPEr01Ke4o8oj2hux7vDZifBg=;
        b=maGOXKAmrdM8nxZHEUop/d+UuilhUKDZOQJRtcJCnkZN91nwunTj6fRcuRkrzIo45a
         sM1gV9zTICeQXqNvlh99edru3BtuFhWITFzbwL08BXRFG0Dtekltw3yvuYZc0kwalYnl
         iL6Gd/BFxTsh1g45Rrm4xzrt5TtANCBle6Q55zmJKOHuH0nalS54LxDhnMCQ7gec435J
         9j83FK/nRbaTZ/jAqqChP3f6wPTZsd3HF+0rP3zXJ7pJcOPXsear9K/uWVJYWhU0Ri1N
         i4DLKMrvBRZHw6wvPXWiw7os94arBFu21yQRRyoAiAJnc72JBNFmLup0z3ahvsSFYaMR
         zPpA==
X-Gm-Message-State: AOJu0YwQetLs1SmHxdACP5XPgGZJ1csuTfYZgIL0Vd4KcnyVxtSTk7a2
	jN9axi6asQSsZkMYt+xCjgw=
X-Google-Smtp-Source: AGHT+IEtDPynFLCBJ8CZ9sVYwIBVHKcmDOmNGYd81YMrMARzhGVKMblOnDqT02s2/bmJZ+q6U+IwUg==
X-Received: by 2002:a17:90a:4ca4:b0:274:99ed:a80c with SMTP id k33-20020a17090a4ca400b0027499eda80cmr6520616pjh.3.1696569065434;
        Thu, 05 Oct 2023 22:11:05 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id d3-20020a170902c18300b001c5fe217fb9sm2743892pld.267.2023.10.05.22.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 22:11:04 -0700 (PDT)
Date: Thu, 5 Oct 2023 22:11:02 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: Mahesh Bandewar =?utf-8?B?KOCkruCkueClh+CktiDgpKzgpILgpKHgpYfgpLXgpL4=?=
	=?utf-8?B?4KSwKQ==?= <maheshb@google.com>
Cc: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>,
	Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>,
	Mahesh Bandewar <mahesh@bandewar.net>
Subject: Re: [PATCHv2 next 1/3] ptp: add ptp_gettimex64any() support
Message-ID: <ZR+W5nkTphcZ1qC8@hoboy.vegasvil.org>
References: <20231003041701.1745953-1-maheshb@google.com>
 <ZRzqLeAR3PtCV83h@hoboy.vegasvil.org>
 <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF2d9jggffd6HtehuL-78ZFPqcJhO+HAe1FX-ehXc5oBmZ72Dw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Oct 05, 2023 at 04:12:44PM -0700, Mahesh Bandewar (महेश बंडेवार) wrote:
> I replied to all your earlier comments

Actually, you didn't.

(no) Thanks,
Richard

