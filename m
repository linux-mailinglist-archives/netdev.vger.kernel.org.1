Return-Path: <netdev+bounces-47126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 243BC7E7E08
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 18:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C8D91C2097C
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E272031B;
	Fri, 10 Nov 2023 17:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lmGZmmwb"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE4871DFD8
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 17:09:49 +0000 (UTC)
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56B243910
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:09:48 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cc703d2633so1132195ad.0
        for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 09:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699636188; x=1700240988; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zJkOEIgZBNPx3yB5KATjwcpVn6VaIfW81wXxRpyA3Fs=;
        b=lmGZmmwbREkSMeQCw6RA1IjkjyYaOJUt0vCrHbTR9gi71f9bJOgJwx28/0bf1gTaen
         GSKvaBkrElaW6ZB5P2H/Y5OBBW7K6zyU7jACNOlmMmK3Mwy69Cv7nwqjSm3ppSs8QFAD
         3sE1ogemum8V95IjKvm7kF2Y63ABTmHyQRD1ncIwntEVU1KZ83m3A8t9v7qFg4N5lIH1
         j7hxkPw/rLxVuvxBBkx0RxVWeXnl2KmDSMfYVZp9DQcjhH8r0cP2cz2vzO1hbiAXwQ/f
         iTccLuqjXmUdLMnQSV6/IExwT+ySFoZVL46pTKxWsg9iTH5Ydn+YJv42Gng70a396x19
         XcyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699636188; x=1700240988;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJkOEIgZBNPx3yB5KATjwcpVn6VaIfW81wXxRpyA3Fs=;
        b=pwnpxSG3cU50KUd+wICjCzgMc5ajhvvZ1LzxaiCZoXS4oTEe3sfOOhAgZg2pbchRqF
         QRXFRc0mjpv9rRvld3uMEiuXLFonJBDCqg4PJqijxn+lseswPCUj2O7kYzmKR1kZXdiR
         BQaA3cITPa2tKFZ6FEFIeDDOBxxboFJ5lbUy7VvB/rUhFcQscOaUX4douJWphWvOcJS7
         j2zEPB57LW2NDDzeVXamYr38g48iQYOCf4dBlC4VNKOkMZxh57cLBhCboXcCPWpwVVFC
         ebjuwSbQHUXuFIjcK9nuzoLiLrsIdacEQrNnGDWoGxXQ5fjy1VUDiMFy6V82yGHKZsm6
         iHLw==
X-Gm-Message-State: AOJu0YyvrP/w6STF4owIHkfTJLiGvaty8egNQoL71Eaf021IBe+wwQLV
	zZ9MTlg34vRP5TFp0w210JU=
X-Google-Smtp-Source: AGHT+IHFs74Fwlz2K7vSeODE6qVQWjcRF2nSl5uOC9LMVY9gy2vPY9lZHDc38aYPyyqRNTaxFgvekg==
X-Received: by 2002:a17:902:c942:b0:1c4:1cd3:8062 with SMTP id i2-20020a170902c94200b001c41cd38062mr9538089pla.2.1699636188250;
        Fri, 10 Nov 2023 09:09:48 -0800 (PST)
Received: from hoboy.vegasvil.org ([2601:640:8000:54:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id t22-20020a1709028c9600b001c9bc811d59sm5556195plo.307.2023.11.10.09.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 09:09:47 -0800 (PST)
Date: Fri, 10 Nov 2023 09:09:45 -0800
From: Richard Cochran <richardcochran@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] ptp: annotate data-race around q->head and q->tail
Message-ID: <ZU5j2V9aUae0FE1o@hoboy.vegasvil.org>
References: <20231109174859.3995880-1-edumazet@google.com>
 <ZU2wRnF_w-cEIUK2@hoboy.vegasvil.org>
 <CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iL5NC4-auwBRAitOiGMEk1Ewo9LOu2TitYHnU3ekzAaeA@mail.gmail.com>

On Fri, Nov 10, 2023 at 10:42:01AM +0100, Eric Dumazet wrote:

> I do not see how races are solved... Shouldn't
> pccontext->private_clkdata be protected by RCU ?

Yeah, the test is useless, because the memory is allocated in open()
and later freed in release().  During ioctl() the pointer must be
valid.

However, there was a bogus call to ptp_release() in the read() method,
but that has now been removed, and so the test is now bogus.

Thanks,
Richard



