Return-Path: <netdev+bounces-59751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3349181BFC9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3948281622
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADF476915;
	Thu, 21 Dec 2023 20:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eonZBhU7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B60768F4
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a2345aaeb05so144661966b.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 12:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703192208; x=1703797008; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Eh1HbWakz9QAqXKTcTVYi4kubyNrrE+y7FwTSgKlLWk=;
        b=eonZBhU74aNj4xXHvT4MpZ+CMOH7jRWKndNdrBz6bTaPUjNmxXIcFYDT6dnT3K4xHL
         HsuRXC6vVc5Qot/LrldbQgcRuLBI6t99byppw9AC/tASXJW1kfljmI3YsWzpRxc25zqI
         ekcd63lr/Ne0XFml8z/alWA3UgGtjzYxaofXVGyUGtCks38ySQkcorkWWUlVigqt5nvV
         Ng7KRbemJmEyS8zhE2xbMLaJ2TZ/nxmPQ98Lg/WtCdIuFhHnnGfDKdhxt+S786RMxFnW
         XcGH4dx1oGpkgUui3xywX97xetUXyXS6E14VYVlqC4gA4A/jw05nBzg7TAHyXDjDlfeu
         hHzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703192208; x=1703797008;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Eh1HbWakz9QAqXKTcTVYi4kubyNrrE+y7FwTSgKlLWk=;
        b=JbaJAbp7rmNpNP7zVWcVyj8ThtHibD8Yc4XaH5xryom4rk+cB6+7+0O173/wF3z1kF
         gjgie7EkoWsEuut4ILjsp+fFPzYK5wLVHlo0ivobmEp5sXoHrzKy0mgqnBMVaKgsb5Jg
         VvMB/Gp3Cjri/ScMAiVqGZ0bAs4nMljVThyKh8LOQUannPIgsQNKre8EeME+v39IvtW+
         oMzGB18iVdYm2iLj5zqkGIrLv8H6fyhAwJuges0YVDqLuVTYu8ZwNK8yhyHD1byjhFa3
         qiEG6ainp2NHF/+zpX/FVj1YVJO+Hijp7FKZlw1ueIZp/26til8krMb28SyrAsIKLrGR
         3wXQ==
X-Gm-Message-State: AOJu0YynEd4hJshZQ3NdEEjMtDis4xL0qfE3b/BS6zxvvIv+TOnhPZxp
	sKdzixl10mhZk+v1S9K7Ni6V1ypXrPrxUheh2wa0h5naRMA=
X-Google-Smtp-Source: AGHT+IHy3bxokS2kvGUw/5qcNicLOFlDRldajoB2eLgAW7rYkYiJvH9iMF5Q8g7x5wELBGiZ068evcH2YMFnJgeZFSM=
X-Received: by 2002:a17:906:caa:b0:a23:2aa8:99fe with SMTP id
 k10-20020a1709060caa00b00a232aa899femr238802ejh.9.1703192208560; Thu, 21 Dec
 2023 12:56:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: James Dutton <james.dutton@gmail.com>
Date: Thu, 21 Dec 2023 20:56:12 +0000
Message-ID: <CAAMvbhEKuYwgXBkkhR6TX8hwje88whAhNaC9A9ssnvXj-mBkDw@mail.gmail.com>
Subject: TCP/IP over USB-C
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

I wish to connect two laptops together with a USB-C cable and ssh between them.
I.e. TCP/IP over USB-C.
This seems to work fine on MacOS, but I was wondering if anyone had
managed to get this working on Linux ?
The USB-C i have is:
00:0d.0 USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4
USB Controller (rev 01)
00:0d.2 USB controller: Intel Corporation Tiger Lake-LP Thunderbolt 4
NHI #0 (rev 01)
00:14.0 USB controller: Intel Corporation Tiger Lake-LP USB 3.2 Gen
2x1 xHCI Host Controller (rev 20)

According to the specs, it should be able to function in either host
or device mode.
One motivation for this is that TCP/IP over USB-C should work at 10
Gbits/second or more, so a very cheap 10G ethernet using a USB-C
cable.

Kind Regards

James

