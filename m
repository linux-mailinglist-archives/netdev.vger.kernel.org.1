Return-Path: <netdev+bounces-46916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03A367E710F
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 19:03:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78230B20ED4
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E127A30FB2;
	Thu,  9 Nov 2023 18:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gd6Mtr+c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC831A61
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 18:03:24 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D9C42139
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 10:03:23 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54366bb1c02so15328a12.1
        for <netdev@vger.kernel.org>; Thu, 09 Nov 2023 10:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699553002; x=1700157802; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wAQNSa46FGuB0h3uAi5/LZq5ypqo1lqwzPUkOnFCUXA=;
        b=gd6Mtr+c+Oj0QZfeDiB/vbhX4I6pxbU6Aw5AcXaSZ7S3UnlFEhqkTXCoH4jlzzTC1B
         Y1l1umqUroZxqKpMl1AlIydyVOS/f79EkdxDvn8lDGe3gqi76J1BwtDvE+BHlhyZhsJW
         a753xYv+kr/Zq3g1FF+KxTlqoAaNviTuBVbIo/qoFyExGHE231vWSocB9vCILz/oxodf
         HjhU2/kcUcRSkPzc6LMJSpiE0tzv+l8cocACqm65E34/chy2s8cIHLECgxtezi2E/kQm
         2efxVnhc1wxwIO4o1jti4n+HKzfpknEdc7HfZqmLNF2c16jI7QivQ9sieecb8flFu+uF
         40Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699553002; x=1700157802;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wAQNSa46FGuB0h3uAi5/LZq5ypqo1lqwzPUkOnFCUXA=;
        b=JH8qwXcReWdW6juGlz7ZEAKfse/xF54YfVSad/w5rPLM50/e30zswV+QMcVZzjQs4U
         CVMcUt4eQHhIB33tmp37iJ22cYbOyJHOwC7EgjoUOu181y4v9Ig20BY59L3+bnwYREkG
         c75LlwWX8koabfgNOF0E3SQeIW+65WIM4HPG27YjmZSngoGncPsFjhZIY6m2HKCYHfuF
         JWjRt8JDFTo2DszLa7aL+7c6ZS3hyo/hj/J+DTxn+kvVx+ITJpyffQotk4iQ9WSecj56
         Yjxjo6P2VXEtp6c8iZDMy/RDRh4UQDUiqQQpNb3KUaLK/zas6E5kPip1i4cZ8RTj1hSH
         oF0g==
X-Gm-Message-State: AOJu0YyzbQnsGnazCFXMsIHIzWxeixTQ2s75fLqP4LP/1ous80Z3ANV4
	0nRwYYpjkFV0jwVAlJw5FyTSzK46muNODea5ENVXMw==
X-Google-Smtp-Source: AGHT+IFfa79r8JzdQtFx04Q0jSwJe+vq28O9bpW9OFC3zu3+PTnIGjWO8f+PDCS9NTgGvNiqIhAC7w7EsVeTZsDdYBE=
X-Received: by 2002:a05:6402:1518:b0:544:f741:62f4 with SMTP id
 f24-20020a056402151800b00544f74162f4mr210881edw.0.1699553001661; Thu, 09 Nov
 2023 10:03:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231108064641.65209-1-haifeng.xu@shopee.com> <20231109095502.5a03bfd5@hermes.local>
In-Reply-To: <20231109095502.5a03bfd5@hermes.local>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 9 Nov 2023 19:03:07 +0100
Message-ID: <CANn89iJqVtN9icrqO-L0fiFNcVRYp7gdu6o8E5q=EUhHHE9WdA@mail.gmail.com>
Subject: Re: [PATCH] boning: use a read-write lock in bonding_show_bonds()
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, j.vosburgh@gmail.com, andy@greyhouse.net, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 9, 2023 at 6:55=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:

> Reader-writer locks are slower than spin locks and should be discouraged.
> Would it be possible to use RCU here instead?

I doubt there is a case for repeatedly reading this file ?

This 'lock' is only for slow paths, it doesn't really matter what it is.

