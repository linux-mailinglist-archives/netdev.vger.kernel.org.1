Return-Path: <netdev+bounces-56122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CDAE80DEA5
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:54:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D01D3B20992
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840955C26;
	Mon, 11 Dec 2023 22:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FMNGJT1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D469C4
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:54:27 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5c690c3d113so4162023a12.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:54:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335267; x=1702940067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yZuMSgGULgu4wyCb8A3ECp+Wd1YSynNVxAxVW4cHL7U=;
        b=FMNGJT1jc0+1gRqx5uqaHdCbI9ytfhxN1bJjhm+98rb2v00wDCbBsuJelr2TM28yUt
         Z4ekqbWv+vy5coZotw1dngKdlChNbeFPacQp3U05P8cS1wTFCsgEbqPM3VoDTLJiT2wD
         dCRy1I1gfdiydryBqmmZAmYjem6hOC6GzoFVwHOlYdGs5lCMZS+db7W5sw76T+8bcl0L
         Bwmx/1bxyIOrfZ8XJb1eOFDM3l0sZ2M7lDMOeH/s698DqPDCQf1JbryrlIhGG/4vOTh5
         7jTdfo5/egWBKKrW1tj8nM1F+8KteBFyTPbQoIdiQqLat3OK8iTEoGM22q96vbtvoGcO
         eq6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335267; x=1702940067;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yZuMSgGULgu4wyCb8A3ECp+Wd1YSynNVxAxVW4cHL7U=;
        b=gdFDRMZ8gnLXQ8LOa6/At/I9HmxonYVPUkoMRP0KYKgzxePJfRTaVZvnrdskjd7yhk
         Ah2ZyKehy5iTdvnWZiqXkyawPt1teIgpQbs5YJlR3lrq9NekgK+tWh7RS1dp4Riki+x8
         5g5/QCiPN3nhahaSDqtCW7cresVKYhI+V6EmdLYuLtHfkh2Hwe1olQkd+StCaYyRHKfc
         72dypVziIwozlnum3K+kDTkl8P8bZ5FvDnck8qoDiFC0JK0LeFvfNzueX6dHiN4JWp6f
         Uec9hfdPFjKR6GeV1+1Al7aELbIDgAGnWcAWYr2y+9nqXzHvG5nRCEjuOkaZN5D7QpMd
         f1bw==
X-Gm-Message-State: AOJu0YxTAg2niUdRtOtgXe0nLze+yfk137nkSOHcq2YKIvLDEEamzB9Z
	H/5FwAgZ8u34sTc+bXJK/KZrXp6yrtU=
X-Google-Smtp-Source: AGHT+IHvKtk90ais6FHYuUEx/orTIK9x1gRkBkklGxzI0ZNfo47j9EwvDUm4hTC8BdwOIXvvJ80vBA==
X-Received: by 2002:a17:90a:fe0d:b0:286:6cc0:cacc with SMTP id ck13-20020a17090afe0d00b002866cc0caccmr4255374pjb.67.1702335266643;
        Mon, 11 Dec 2023 14:54:26 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm7594587pjb.35.2023.12.11.14.54.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:54:25 -0800 (PST)
Message-ID: <7004816b-24bc-4f56-b915-01fb0830b7c7@gmail.com>
Date: Mon, 11 Dec 2023 14:54:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 1/8] net: dsa: mv88e6xxx: Push locking into
 stats snapshotting
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-2-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-2-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> This is more consistent with the driver's general structure.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


