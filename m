Return-Path: <netdev+bounces-57333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DAD812E49
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 12:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8467CB2129C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C9F3FE5B;
	Thu, 14 Dec 2023 11:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SEN7TBOP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20E78E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:45 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c31f18274so76659505e9.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 03:12:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702552364; x=1703157164; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+awbDbYRppxhyiKn67j5nTOqvsR+tFdedweDtgr3TQs=;
        b=SEN7TBOPgoL/wKcb+G7Rkpes9hIMx1/bOUfAT23Lu7NmAglpJHH+nH1EKkYPFZvMmA
         AMxu7xFvTQIwp39dla3BtqnPrUeptNBeUylfhSXO2LZt7nH/FAsQ1ZN6rEgx2P2kiNwB
         ueXvOtv6uZp72VdY1szwtpxU1EUB5yG/vX5Pa35uGdPEGn/98whEIefegsuKrAxkvTl1
         A1KQGrZy23tWVq52YxwpcXmY2I8MowGKBG+J6no6xMZt7VE6nWlac6J4Q5Z1GL8PBBV6
         8KwiNJopPUyqAfUY6+MzbI6kQH0YuIgiwX//XYYhfcSikvq2vq1W9SUDm5ISQzg/D2QI
         OuTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702552364; x=1703157164;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+awbDbYRppxhyiKn67j5nTOqvsR+tFdedweDtgr3TQs=;
        b=WN1/A021qpUQCIt2Xj/Jt2+R/0wdpRUzvg2dVhwxSeHerhJEZvlMYitRVYX8xjVe6Y
         MgNNu7WaWpDwycI9qKYmVPzsnReWIaLAAP4076dkDaBfbZaRaJ4KsbSHp1/rjUfl3qee
         Ofl6cBIvG9iTrhaMfsRZnwhTCZOBJtVW5FB88Y2FnZ1SwTT3SmrhZtPiuJGVc93kIw0w
         f8fAGHV1hwT9QP0Y1+JZOExaEp7AZUtUv0pqWPNs5j0PBnXR0Y0wzcMNN9SD8s2zLWoS
         Xbr6YhoguZd9GXBpwzYJ/Wzl3hJjM45xkwdR0WekTQrgfKkOT/VGjBffhEoGWdztqn4k
         Q4EA==
X-Gm-Message-State: AOJu0Ywur/Q5N1a50pxKdudOcZvzfVnCmUYvmpdUPScLSnjfcdcBFZDQ
	9HNXqZH5+ee4084HvYB0/Yw=
X-Google-Smtp-Source: AGHT+IHXZYjNvWHK/DCPgWxzFh6UFGPQBA8ZYNK7ynHh8tr4j7yUtxliHhcZfYCrn3cXJedCyEpABQ==
X-Received: by 2002:a05:600c:1ca9:b0:40c:325b:6360 with SMTP id k41-20020a05600c1ca900b0040c325b6360mr4324085wms.130.1702552364187;
        Thu, 14 Dec 2023 03:12:44 -0800 (PST)
Received: from imac ([2a02:8010:60a0:0:7840:ddbd:bbf:1e8f])
        by smtp.gmail.com with ESMTPSA id h5-20020a05600c314500b0040b56f2cce3sm26333748wmo.23.2023.12.14.03.12.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 03:12:43 -0800 (PST)
From: Donald Hunter <donald.hunter@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net,  netdev@vger.kernel.org,  edumazet@google.com,
  pabeni@redhat.com,  nicolas.dichtel@6wind.com,  jiri@resnulli.us
Subject: Re: [PATCH net-next 8/8] tools: ynl-gen: print prototypes for
 recursive stuff
In-Reply-To: <20231213231432.2944749-9-kuba@kernel.org> (Jakub Kicinski's
	message of "Wed, 13 Dec 2023 15:14:32 -0800")
Date: Thu, 14 Dec 2023 11:11:40 +0000
Message-ID: <m2ttol3uoj.fsf@gmail.com>
References: <20231213231432.2944749-1-kuba@kernel.org>
	<20231213231432.2944749-9-kuba@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jakub Kicinski <kuba@kernel.org> writes:

> We avoid printing forward declarations and prototypes for most
> types by sorting things topologically. But if structs nest we
> do need the forward declarations, there's no other way.
>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

