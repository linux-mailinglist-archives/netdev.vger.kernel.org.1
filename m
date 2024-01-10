Return-Path: <netdev+bounces-62889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE75829A85
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 13:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09A9F1C22108
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 12:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68A347A55;
	Wed, 10 Jan 2024 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aW42wvlq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5313C092
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 12:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-50eaabc36bcso4998506e87.2
        for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 04:44:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704890639; x=1705495439; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ToI9XRqDxJp6IyAj5PSVv/LwwOi9rz4J2ohc5Cr4EKE=;
        b=aW42wvlqNe9M5FR//QpGW5bLJ5XEpKYk1UcmbdHtHka4dAoQ4xCGAIcNRwWPoDCBr5
         NFvFI1r/JV6buoNBoYB16Ym70Lq/A1BDNBmMHTA/ZjvV/o31tZu69RSI/dwW7MFSfJSP
         3wJ+gPt4ik9Soukbs1yjjNX7KJ4oe3k1cpBIzvmHjS5i8njxx4LiZYlk/anPfVt9OsXT
         aNAS9gFlj5UrmJ2gaPPI0q0coeNQQr2712XuqrgDsjxdv6uugAn6+rqNbIO2aa8YTISN
         NausxLTfFsyLkXLA4IYmfkjhL8hSi8mJgAwC/ke8KC91c4ZFBYpoVy7xuPywk0zMPCup
         dEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704890639; x=1705495439;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ToI9XRqDxJp6IyAj5PSVv/LwwOi9rz4J2ohc5Cr4EKE=;
        b=U1XefFZ234v1EmrX/Cq4+bJOGmdKGz62iq7NyhOtqxtMXfI9DOApXAk56dSjp1VYW+
         h4nADWXu+O619EC5p+GrDNNejCi/MxyJZvlXusP4kfpqp9IoX5wTWnIz7AFX8f9pTL7A
         1e0YU1IJQ7rUk6RcIX7Ga9I1bM4PjSvqCyKYqkZMhQ5zMnHS7U/4C0I2LNiqqbzx6uUs
         RODYs/sB3nmOuKYqr4X3Ye7EpsgAWE0NJhIfsRDIODWqDpx4dHWZiIBpxbO8/GCnUxBw
         NUuJJU3YI4vz2VbHob1PED/BYfWbkOrwERfT/q6/IO/uOJuroH+dTJa/3lVY9O7g51WV
         j+Kg==
X-Gm-Message-State: AOJu0YzrYT2TzNKAa+/xdJ3W9XpKahXVnnj2gCOiCdB33uvVVbawheiQ
	Rb2AXt25vUa8p70UIDX5AjZmlYZTZ2LFyA==
X-Google-Smtp-Source: AGHT+IGqcC5GfgFja+eZrFmfpFARLbyZvpI3gjwmVv1OceKVFqwjHqzsGkJ7S9sz8YnxcSKgSL+wvQ==
X-Received: by 2002:a05:6512:202a:b0:50e:9353:b8b6 with SMTP id s10-20020a056512202a00b0050e9353b8b6mr370149lfs.93.1704890639100;
        Wed, 10 Jan 2024 04:43:59 -0800 (PST)
Received: from [172.30.205.119] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id q13-20020ac2514d000000b0050e2c05576fsm658430lfd.9.2024.01.10.04.43.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 04:43:58 -0800 (PST)
Message-ID: <74374085-8185-4377-ac61-e8f16d588a92@linaro.org>
Date: Wed, 10 Jan 2024 13:43:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next RFC PATCH 1/5] net: phy: move at803x PHY driver to
 dedicated directory
Content-Language: en-US
To: Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240110115741.17300-1-ansuelsmth@gmail.com>
 <20240110115741.17300-2-ansuelsmth@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240110115741.17300-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/10/24 12:57, Christian Marangi wrote:
> In preparation for addition of other Qcom PHY and to tidy things up,
> move the at803x PHY driver to dedicated directory.
> 
> The same order in the Kconfig selection is saved.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---

This thing could use a MAINTAINERS entry too!

Konrad

