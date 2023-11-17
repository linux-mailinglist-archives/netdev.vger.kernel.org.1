Return-Path: <netdev+bounces-48863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9F47EFC53
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 00:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED566B20A4D
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 23:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F6024776F;
	Fri, 17 Nov 2023 23:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCJL40iU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D8E1A1
	for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:57:47 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507be298d2aso3344283e87.1
        for <netdev@vger.kernel.org>; Fri, 17 Nov 2023 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700265466; x=1700870266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RjVbPWtP8LjZJLsEaLgQrThLRhsfxmvypnJxdHR5WAs=;
        b=OCJL40iU7zR6IvYH1x4Sk1DVKvvdxaaxeYqGr92fLKwf5LYPn+g5bkWjMuF14Xtip7
         lTY9fmqDx4/90npO20UZ24DZ0JBYM9blRknZMYEsSH43zctaITbeYZaVvVrGwb0OmBz8
         egZC5oOKwjge7Kio0lFHtIi8exfzzv7Q41qixd4dTuNxoqPi01xpNEJsNPtRZ4irRRLK
         u2zpi431GpB8SNeD6TXslmMn6PW93MbOwtpdFYUWrkWNdibvsoy6OnoJAOigtOLyWTXZ
         d21InlZIhhR8iAyzrYUeB+spC44SZiTP4nIxsEeR5Qqk+3L6rncKaz8hRHnrNx0tf9NV
         CKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700265466; x=1700870266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RjVbPWtP8LjZJLsEaLgQrThLRhsfxmvypnJxdHR5WAs=;
        b=UbNcYosL/qXCailanPM146sQKaCyOncOBPlah0z/5p0s0gTREyhrioyEomsF5IYPva
         znliqzkyjA+2GqmxYQECQG4WfygWLyA8IxQu+YFYEauZpssT+e2Nu1UGRsmXLLvtrMHH
         J84s/3BKkXFGoPecb4UkTUW59nm1OdxDHwSXLYZKjjbKW1e0ERYFe1nRQOFBxg6XgYXw
         SNmhYbTXb6XhNM/qTJAJFfKOC9hSK5UXpAZYxRMu94z9CUBPxMT/AJBdjTGp8tuSByVg
         hHbciRGFXKCg3UiiCjzERNQIR96nEwpbyiChtedX8+JdAia/4SGe0noh2f+2o2hcPEqO
         w8cw==
X-Gm-Message-State: AOJu0YyyNizh3+b5oxMO8BOiR7NVepuH+C/RHBYqx770j35UqFl7MuQe
	lebH6ioMKqLg8tHzx73WmWAW5foL58vNLZoLZGDzBLL2S8v4KA==
X-Google-Smtp-Source: AGHT+IECL9/DJvGvbrwdv0bZDXVLktb2KXGdQ5u/kxXeRPDqP/Mz7FijEy7tivkmiMR1mGePqgs4bG8ntF4wPYCRWYg=
X-Received: by 2002:ac2:4283:0:b0:509:8e81:1aa4 with SMTP id
 m3-20020ac24283000000b005098e811aa4mr667842lfh.39.1700265465633; Fri, 17 Nov
 2023 15:57:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231117235140.1178-1-luizluca@gmail.com>
In-Reply-To: <20231117235140.1178-1-luizluca@gmail.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 17 Nov 2023 20:57:34 -0300
Message-ID: <CAJq09z6_4H6ZZJrjXZALuL9aHPy20FzvUivWfvSZRU1AXUX-Rw@mail.gmail.com>
Subject: Re: [net-next 0/2] net: dsa: realtek: Introduce realtek_common, load
 variants on demand
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org, alsi@bang-olufsen.dk, andrew@lunn.ch, 
	f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	arinc.unal@arinc9.com
Content-Type: text/plain; charset="UTF-8"

Sorry, I used the wrong prefix. It is missing PATCH. I'll fix it in a
v2 after the first round of reviews.

