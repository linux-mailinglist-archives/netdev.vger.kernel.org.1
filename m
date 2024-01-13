Return-Path: <netdev+bounces-63446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45782CEE7
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 23:22:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 248E1B2215C
	for <lists+netdev@lfdr.de>; Sat, 13 Jan 2024 22:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7E416439;
	Sat, 13 Jan 2024 22:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="anpB2pnz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85630168A2
	for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 22:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e69b3149fso14380045e9.3
        for <netdev@vger.kernel.org>; Sat, 13 Jan 2024 14:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705184519; x=1705789319; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:sender:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HIafZnX2HaaS3KcRFITD6MGDONWRf0gV6f4VdCyfFQI=;
        b=anpB2pnzrK42mbvO/J5OHmLMkjswNqI8BzXCcyxXUaWWlKAaxPQBqoKAJj1LhYJX9L
         9iPN791Fd++KxLoiVJhFrM/vhxOAk1lKtyF6IpKl4ONy5wqONzuH9i2QkwD+eRZt/1FR
         CIPb6Qthj1bZZNwvFZYvArH4kuQWTw44yemIsgPybHKTI8lO40aX1n4SVA3oEqZQM7NQ
         GmBt2C5tkZuPqujaCTL7a1B/tf6KAQj4H3sJDqHA13Ak1zuEBIdav4v1qhFrSLMW9VQ2
         nhFGNw6MmEouyOm0MfmsgQBFKerUjylsevutyfDlHir20gEC3Oi5i5ft38jUbIw6u6pV
         LQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705184519; x=1705789319;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:sender:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HIafZnX2HaaS3KcRFITD6MGDONWRf0gV6f4VdCyfFQI=;
        b=i5uvN4H4TR+yYg+RUyaYeyXiV+KXxpKXV9Ti3uFOjGZseMb3IZx9EsvnzANYrcvxiu
         ENwR9bSkYba8aoedeVyCGLzA+VVEOOunPuIV1ozOOkeYZU5tyrh0ZvWOk9ZuxRMes9tr
         4jW5xBl1ZHuxw4uGwMF/9zpVzGwtOartPYJl3ZWFhoLaIEFm4e2YVaKAKecfrAcA3yge
         0TDPZveZsG8FJ8iQyqiOC9sNQ04M7KBPjuSEgybJeerk93Dh9pQUGy+hqjjDpUtClc3N
         Y2mYEyKj8dndJHETYBZruilMHgxJeBjQ6G3xQK9Gx/Ju0LABLORLOUgoM+mXVL8Yxfw5
         YQXQ==
X-Gm-Message-State: AOJu0YyS73SkiqChOZi5AOU9fJXukF74EcCymTt5M5KJL4eUX/g/FTSC
	jicKuwV+RQWhjQ8hOoIOoMTOpWwCjIE=
X-Google-Smtp-Source: AGHT+IHk1sIXU0VA4RhwYAWZ/gdTxgUm3prOTAIUOK/faveGgrnfnGZJgq0ceE3hAWLwBwJPBJ0tHQ==
X-Received: by 2002:a05:600c:a47:b0:40e:52eb:2996 with SMTP id c7-20020a05600c0a4700b0040e52eb2996mr2037953wmq.8.1705184519609;
        Sat, 13 Jan 2024 14:21:59 -0800 (PST)
Received: from [192.168.1.71] ([102.64.213.238])
        by smtp.gmail.com with ESMTPSA id d6-20020a170906c20600b00a28c8ab1342sm3324066ejz.96.2024.01.13.14.21.58
        for <netdev@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 13 Jan 2024 14:21:59 -0800 (PST)
Message-ID: <65a30d07.170a0220.1eb2d.e045@mx.google.com>
Sender: Roberts Kevin <donemstg@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: subject
To: netdev@vger.kernel.org
From: "Roberts Kevin" <rbkvtg@gmail.com>
Date: Sat, 13 Jan 2024 22:21:57 +0000
Reply-To: robertskevinesq@gmail.smtp.subspace.kernel.org,
	com@web.codeaurora.org

Moje meno je Roberts Kevin Esq. M=E1m z=E1ujem diskutovat s vami o obchode.=
 V pr=EDpade z=E1ujmu potvrdte

