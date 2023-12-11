Return-Path: <netdev+bounces-56127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FCF80DEBA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 23:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5661F2190B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 22:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7455C37;
	Mon, 11 Dec 2023 22:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PaL8/0vM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D39AE19D
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:58:01 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-286f8ee27aeso5237146a91.3
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 14:58:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702335481; x=1702940281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LSs3WksmerOZPHJ1LU9TrjNbQyPbeVFhDZ7M205aQKA=;
        b=PaL8/0vM0Hx4nxTwq3W0Goj2bpsPOxjUq6Ycbo5qaEVXG7uF4Y68lRpmyKBjnOzDgV
         V7WQ/IKiJbR1dCGbiMrxUL67T1O//5E5oFrvEy9DmIozLeLNiA5UM5vFB6cui7O9O6b3
         I3eh0nRZ65zLlSSCYmBN2asvuLdBPx2sV0BjyXySjKnrEBDm257zmKTaVSMyt5t2y3Gs
         9QTQ0ZuYgJckc8dZOMEpiv0JypAYWrGCpWQRgbu2i1sdv2Z0ohHvm5d1VgLNuDoQ//QL
         mwu9GY26nW8M0gRpRdBSqawdChR/fojbGSdCy8PyTvHoAQ0/Ml0deQwPpMl9WWuTealj
         8AXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702335481; x=1702940281;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LSs3WksmerOZPHJ1LU9TrjNbQyPbeVFhDZ7M205aQKA=;
        b=UREBZNfofMSZ2SfwWFuP+a4EfTalDuwzvocMJKuqEXgeqe+JaEBP0Vn92FFsD4+WC0
         Xzkl/mL1zx4eDOzLJCWv1vLJBawRRRriuzSxqqBAK89vpr8EghUXqErA7WF/o0kHfx+4
         o6+oduHPSFZu6newl5cDbny5gi7NQrxBe42SLrUatQ2Yr2tNcFK1X3CZmBfBeCVjkP77
         EqgPDdYA6+SNhxtibt6zis6bmKfZSLK1snF4gHYkeuQdf5uv5oml1ggUs7DPiEeUiYl9
         /UD8EhnVx6cG0GvNxj7p5e2YZ2WWAFrwOZ7l29o3b123rd+71aU+z68btAMUBUWch/cT
         rP/Q==
X-Gm-Message-State: AOJu0Yxios7BEOuqf0Bm3bMEDx0OmPYdTfMpO6Th1Xsyps0UlgZSre0f
	9Gl8Vz7uVqgfMlTyGPAKsQA=
X-Google-Smtp-Source: AGHT+IGZTD4RyshO1XNj9PQgJS3Dx3jhVg1WqdXuPxYvcZusvuo/1OO77ETpqA5CibInLR+WAjOd9Q==
X-Received: by 2002:a17:90a:fd13:b0:28a:9f67:e9d0 with SMTP id cv19-20020a17090afd1300b0028a9f67e9d0mr1468889pjb.92.1702335481275;
        Mon, 11 Dec 2023 14:58:01 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id qj12-20020a17090b28cc00b0028672a85808sm7594587pjb.35.2023.12.11.14.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Dec 2023 14:58:00 -0800 (PST)
Message-ID: <d0c8b805-fe33-40d4-bb44-8e6258d2b9de@gmail.com>
Date: Mon, 11 Dec 2023 14:57:58 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net-next 5/8] net: dsa: mv88e6xxx: Add "eth-mac"
 counter group support
Content-Language: en-US
To: Tobias Waldekranz <tobias@waldekranz.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: andrew@lunn.ch, olteanv@gmail.com, netdev@vger.kernel.org,
 Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20231211223346.2497157-1-tobias@waldekranz.com>
 <20231211223346.2497157-6-tobias@waldekranz.com>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231211223346.2497157-6-tobias@waldekranz.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/11/23 14:33, Tobias Waldekranz wrote:
> Report the applicable subset of an mv88e6xxx port's counters using
> ethtool's standardized "eth-mac" counter group.
> 
> Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>

Not usually fond of defining a macro with a local scope, but no strong 
objection either:

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


