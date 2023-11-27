Return-Path: <netdev+bounces-51407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABD47FA8CE
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 19:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D82814C8
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 18:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5517F3C49B;
	Mon, 27 Nov 2023 18:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HIACrthQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2329194;
	Mon, 27 Nov 2023 10:19:25 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-77bcbc14899so262040885a.1;
        Mon, 27 Nov 2023 10:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701109165; x=1701713965; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5qzQ5jeraGpYSm3FpmqL9etjlYc/TVcStCfVUmtTsyo=;
        b=HIACrthQuZNNfi2GvxAkHUmki3wkb0T4CRQM0pAN0gbioOWCDiADj086Yj/aJEEl0g
         w6tBJtwJQ4iyeHZ5OFqxnHF2lJwvQs+ZimurvQBGQvoM+7cygj/yeUF9Afgt7zVzYN0e
         CyG5BW6DVw+Anz+HK4ZuGcMJFUW5OLaT2T5IU4jHGcOgT94EkY9kHzl/KWMU1xanaV6s
         /8DpwtQdJmLc/iEHwPSD4Zl1q+0LtyoYjjZgUTsL8/mwiTI9e7lCmr+p1iOPvOzqmP9v
         U6SfDGl30fKTkQrvMDyx2NfrhUKpfAzByNkzbUaDoyUZgr/jJvaVJS9FfLwWIkMgpbcm
         sSiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701109165; x=1701713965;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5qzQ5jeraGpYSm3FpmqL9etjlYc/TVcStCfVUmtTsyo=;
        b=O3Syn5AI5h6qBtfsCWpuMYR2dytVcEM1WRz4AT/FIX8fpUgHdqw1frMfRa9h7dUvGf
         oK6Pg1ES6UeP6xBJcI+ijFtwiA+YV1qgvGKLzHgvdP9aOvbIsW/x6ers328KGHYspdaL
         bSomOLg4JiimOypG39afFY2dUccz9OufZxh8MgDAWggu6tMXz8510YPQzvDDSqNC2zvY
         CT72vF1FyxdGD7ShtFBV6ETcjyP+AJ+KSJKlZrerQmNM1TQ55aAk7HVHCzRU5aRPSXGB
         a3T3xStg6eHV/YBqRjWVu2Ux8qOhu/f9JDb+6KupyevFXHJ0lg/3h0ZOgKkduDaQd+tD
         P7ZA==
X-Gm-Message-State: AOJu0Yw49aS1NMRDHXm6EZGRDljwpjiPX2rrMLBdA+8lkqrCgBo9EqlR
	TKtr2grBsQSJwvKmG2qdDMM=
X-Google-Smtp-Source: AGHT+IH74IMwgDe+ZnPL6RMPBzM5FqZt2ybZedW2xj+iYX/04nmo23R409BH9yUTSBSXHIHAOKHTlA==
X-Received: by 2002:a05:6214:190a:b0:67a:3f40:4bf8 with SMTP id er10-20020a056214190a00b0067a3f404bf8mr5018182qvb.19.1701109164719;
        Mon, 27 Nov 2023 10:19:24 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id ee5-20020a0562140a4500b0067a22a8564fsm2872202qvb.140.2023.11.27.10.19.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 10:19:24 -0800 (PST)
Message-ID: <455296c5-a453-41a2-9c8d-e50146ec75a9@gmail.com>
Date: Mon, 27 Nov 2023 10:19:22 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/3] net: dsa: microchip: ksz8: Add function
 to configure ports with integrated PHYs
Content-Language: en-US
To: Oleksij Rempel <o.rempel@pengutronix.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>,
 Arun Ramadoss <arun.ramadoss@microchip.com>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com
References: <20231127145101.3039399-1-o.rempel@pengutronix.de>
 <20231127145101.3039399-3-o.rempel@pengutronix.de>
From: Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20231127145101.3039399-3-o.rempel@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/27/23 06:51, Oleksij Rempel wrote:
> This patch introduces the function 'ksz8_phy_port_link_up' to the
> Microchip KSZ8xxx driver. This function is responsible for setting up
> flow control and duplex settings for the ports that are integrated with
> PHYs.
> 
> The KSZ8795 switch supports asymmetric pause control, which can't be
> fully utilized since a single bit controls both RX and TX pause. Despite
> this, the flow control can be adjusted based on the auto-negotiation
> process, taking into account the capabilities of both link partners.
> 
> On the other hand, the KSZ8873's PORT_FORCE_FLOW_CTRL bit can be set by
> the hardware bootstrap, which ignores the auto-negotiation result.
> Therefore, even in auto-negotiation mode, we need to ensure that this
> bit is correctly set.
> 
> When auto-negotiation isn't in use, we enforce symmetric pause control
> for the KSZ8795 switch.
> 
> Please note, forcing flow control disable on a port while still
> advertising pause support isn't possible. While this scenario
> might not be practical or desired, it's important to be aware of this
> limitation when working with the KSZ8873 and similar devices.
> 
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
-- 
Florian


