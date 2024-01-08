Return-Path: <netdev+bounces-62326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F11F826A98
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 10:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21895B21939
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 09:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E96751170D;
	Mon,  8 Jan 2024 09:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O8HUrfcz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5974612B6B
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 09:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso11844a12.0
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 01:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704705638; x=1705310438; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=niwqY8K4e/WW0GFXJl7RQRrtTccn+TnvpnQmZx+xTp4=;
        b=O8HUrfcz+VmzXbYZWmlcQpeo5vkxh3bm9EKCI/VF8lZCORxGK869kOiCEoYWfQ7sS+
         iv7iE5WVIGZ9PD4sff7eAEmEfNkmKCO4pdJoQQWRw0TMfAzsgDV9AogA1cDlK/YoxfP/
         auUkN5AQ007odKjiIp09YPbwfl99M/Eb1ViZHtCI8nwSJTzP2hw7hjksXeNVwFg92GIS
         IGQ8IZC8lWevC1GV59hshNJXDlZWVYey4znDmjZNvpivO6gqR+8FJsNUjm3BxPjsQYNz
         EwRA/o4XOFNPC/o8XFmjSV6iJ8SfXkavuWW29fsGKnSn8DjzAqBiijlITYoG1QXx2Yml
         F7TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704705638; x=1705310438;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niwqY8K4e/WW0GFXJl7RQRrtTccn+TnvpnQmZx+xTp4=;
        b=PCMzP+Jlu3ucLavQPNCWgQZk8euxd03qxFs7EdAKRGMv+H8+JKvJSRqOwqfnyn/vVz
         o2x3/WHOfJApNfZo3TR30VX/tDMQiI6lhH1Vzt6AC0rA9oepgB2lkGJ9waqwzmOsgMgL
         31K2LE9tuVdcQ5bQJb+0tA3uoRjN6/tDpftLdLui/CLnNuALkKzvkfR+NSRUg4PITygh
         i7lsyp4KoRykOYQklx5bvb1USCU7JXqs83QsCdxXirEP6Y+rWbS3RXH0H7wQX6cI09ai
         ufy1vS8d4fwjQ2U15/zmNAcgqM5sY8dSOSDjLyVJ3DnFEVgk4TR73HggQdxVpgTWAMmV
         ppdQ==
X-Gm-Message-State: AOJu0Yxr8a/5OKvFolf0Atr5/0ZtotcUi2LKxNjeVk+7Wmuo6thohrAb
	HBSZgC0iT3QomvQEEyGh7I9RnAEjRRQ18/PRx2Qu5WNngqiP
X-Google-Smtp-Source: AGHT+IHoCnSHzDbJ2ryg9M8x56lHtZdoK4IGjK2m03FlYTHSvkeZ88r7Cnd3Te4ej0F4prpD5WPbosqCIHG9SMmQb8w=
X-Received: by 2002:a50:9fcd:0:b0:554:1b1c:72c4 with SMTP id
 c71-20020a509fcd000000b005541b1c72c4mr197017edf.1.1704705638343; Mon, 08 Jan
 2024 01:20:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240108011131.83295-1-shaozhengchao@huawei.com>
In-Reply-To: <20240108011131.83295-1-shaozhengchao@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 8 Jan 2024 10:20:27 +0100
Message-ID: <CANn89iL+JDghoudzGfGgeQkwDrtOHKoDbGiaracs0foWm+Pmpw@mail.gmail.com>
Subject: Re: [PATCH net-next] fib: rules: use memcmp to simplify code in rule_exists
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, weiyongjun1@huawei.com, yuehaibing@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 8, 2024 at 2:01=E2=80=AFAM Zhengchao Shao <shaozhengchao@huawei=
.com> wrote:
>
> In the fib_rule structure, the member variables 'pref' to 'oifname' are
> consecutive.

This could be changed in the future.
This is error prone for no gain (as David said, this is control path)

 In addition, the newly generated rule uses kzalloc to
> allocate memory, and all allocated memory is initialized to 0. Therefore,
> the comparison of two fib_rule structures from 'pref' to 'oifname' can be
> simplified into the comparison of continuous memory.
>

