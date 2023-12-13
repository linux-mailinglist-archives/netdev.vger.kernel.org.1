Return-Path: <netdev+bounces-56738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191B5810A3C
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 07:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 490FC1C20916
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 06:26:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6902F9F7;
	Wed, 13 Dec 2023 06:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jev8JJ+W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2393AA7
	for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 22:25:57 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40b5155e154so75249895e9.3
        for <netdev@vger.kernel.org>; Tue, 12 Dec 2023 22:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702448755; x=1703053555; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:sender:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7LL7VmLVs6nNnr30U9bF9ydtRKs0dP8xIfDq5HqvVQ=;
        b=Jev8JJ+WWCSVueKnG3yRnBSe8JxkzamJvdj5wllwMod7/bLIZxYMUK7x5eG37IDK9A
         khWpxloQFjhZdl1kDuwERn7WCpJe7XVHW9wDYUR+c1uh7Xwgxt3IDBp5ST3fKp4WUb2o
         jk649yIT84b5xxJAvI7nlgbotCVhyv7aKMpYz2hD3QoOElielQy3DSQJCQM8cO5HXAaR
         fnO7xnZu7n34KzA+QK0ydiyDNfAn3lqf9Ute8SVJvtTv2M70ji+ulfbR2nkbXQ1pXQIY
         wPxI0mIhCplgiBwtgrYq5AbGsBficJSo49KneuELuXngyuLNxopmFkCJ1T+5UfOFZ4eZ
         4EEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448755; x=1703053555;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:sender:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y7LL7VmLVs6nNnr30U9bF9ydtRKs0dP8xIfDq5HqvVQ=;
        b=Y1goWW/ICEKrTtV7azOEkwKANIFB3NuJfLQq4uzKQswyHLkDMSyjtQC7eg2Utmsz+H
         GxxXq7+aOsrCNlUSKEKPFeD4gtbu/zv5P140H3uVoVHuMkNnEFvP8d1KtRxMd2jKKEXQ
         oAeZGTkO/7NvUniJI8XP6VsAfd3GTw0RQo11UtJR2NoZPHy5jkOEwYuG8IFl8zp0oma4
         Cvr+gm4VMqXhOA/5gr/UsQ/0kl73+g5DoEgVq/6TIqCJ7QLH+gCw7ZATll44xrx4yoHq
         rCWC9mAHTiHQ3D6Unv5oIEjvbRCOxvgqDx7zPxiyHfRLZdqUYjVWGKFV2B8k+RfWNiEl
         1sYg==
X-Gm-Message-State: AOJu0YzW2ztGEWoaV+A4QCXRNWKv3P7RY2fZyE0ARQZd5X0RSwqlRdJE
	Yp3WIVZzztocaKGBmj3YNXbogrZ0Ep0dcA==
X-Google-Smtp-Source: AGHT+IFAF8/L5WvI1loFhjCuWzz95pevE6oZHDR5CYI1DPRQzRtau3+QFFT7LgQqYeWwSpuxOK/TNQ==
X-Received: by 2002:a05:600c:b43:b0:40b:5e21:bdb5 with SMTP id k3-20020a05600c0b4300b0040b5e21bdb5mr3660346wmr.68.1702448755200;
        Tue, 12 Dec 2023 22:25:55 -0800 (PST)
Received: from [192.168.43.190] ([102.64.208.203])
        by smtp.gmail.com with ESMTPSA id e12-20020a05600c4e4c00b0040b398f0585sm19371013wmq.9.2023.12.12.22.25.54
        for <netdev@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 12 Dec 2023 22:25:54 -0800 (PST)
Message-ID: <65794e72.050a0220.59e4a.5da0@mx.google.com>
Sender: Sharon Andrada <andradasharon782@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Hello
To: netdev@vger.kernel.org
From: "Sharon Andrada" <sharonandrada8@gmail.com>
Date: Tue, 12 Dec 2023 22:25:50 -0800
Reply-To: sharonandrada8@gmail.com
X-Spam-Level: *

Good morning,Can i have a word with you?

