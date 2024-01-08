Return-Path: <netdev+bounces-62421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 584358270C7
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC833B218C9
	for <lists+netdev@lfdr.de>; Mon,  8 Jan 2024 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9609445BE1;
	Mon,  8 Jan 2024 14:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUPmNWCi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A79047762
	for <netdev@vger.kernel.org>; Mon,  8 Jan 2024 14:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a26f73732c5so188863066b.3
        for <netdev@vger.kernel.org>; Mon, 08 Jan 2024 06:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704723140; x=1705327940; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iNg1VgM1zaxXXuJdH1EPDT6Exglx23tZ8yxDmQQqhiY=;
        b=ZUPmNWCiuefekAY9vtfiGYWlLx0LauXg+m4wLmLeEXM0A60CmhVlwJo0b0WVul+632
         oU2Gy9v8j3BYQveR2t2qNyviJEqSp3pfpnyjKNzCoX3Dvv3O9K3vbZk287ZccCdiuLdi
         SKNEIEbFkiM8ViGwv2iOLEvtF0pZ/zwbYe+yQ8o4K/XqsIHQqJfTy0loZCEp/6ILQhe5
         9Nrf623nptXFrCry1CDmjdwm2PVYTxCK1iTPKHPMgzWdj4aLsyAZUwfxL3kei3+wNy8r
         /ZX3TNZikauOqiE06Am66vflXWEC9wdRxFfTxr5d7I4F/V6TvrEtFWLANuMFqN0OhVMv
         E2YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723140; x=1705327940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iNg1VgM1zaxXXuJdH1EPDT6Exglx23tZ8yxDmQQqhiY=;
        b=YzOH9kXjFG1AQ3H9B6KwkcZA43lwS/so2Mr4lgQEg0IfXsxpqnvEsezdvRCUd0OXIA
         M89R5VohxtMQqjBnCBNjYAKsuqd7XqdS4nBl18VMaSb90ZVjPvCSTmwHj/AFjapgjjyR
         Wlgf6sIMc3w8ZpvDF4y7J/OUgbUFGn+Co65o/HEpYw/mIto5lI1/Ek6Db63Xdlb2Rjix
         Dhh9e+FU2/mgt+33ujGNVg6C3QaGlE6+mabaYIQB6ROKR0CVn1cDAjFl01aYU5Z7aqXd
         D7nHrQ8n5TvOiNudMROOhCWtJRzvJaN6ru4cHYacTLwznKvHVrArpvcqogejzdW8B6Sy
         H1nA==
X-Gm-Message-State: AOJu0Yw8HO0G73QEcvKvlVxNh7CLIr7eXS7Ju5TQ3F8cxMF+gMINCdJS
	q+r2u6X2jqYD/eNcMifZMI0j/uDOwLrspg==
X-Google-Smtp-Source: AGHT+IGQxK/Xmha+2S30LLYUlW/hAJl/Cge+JImSKNxG3btSFUZmLgMi23W8gOVjXYKREvGDIhxj6w==
X-Received: by 2002:a17:906:1096:b0:a2a:35fd:9b93 with SMTP id u22-20020a170906109600b00a2a35fd9b93mr1106449eju.91.1704723139979;
        Mon, 08 Jan 2024 06:12:19 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id mf4-20020a1709071a4400b00a29dcbe1e72sm2636942ejc.56.2024.01.08.06.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:12:19 -0800 (PST)
Date: Mon, 8 Jan 2024 16:12:17 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: netdev@vger.kernel.org, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	andrew@lunn.ch, f.fainelli@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	arinc.unal@arinc9.com
Subject: Re: [PATCH net-next v3 5/8] net: dsa: realtek: get internal MDIO
 node by name
Message-ID: <20240108141217.uvidpsczszdzqnjy@skbuf>
References: <20231223005253.17891-1-luizluca@gmail.com>
 <20231223005253.17891-6-luizluca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223005253.17891-6-luizluca@gmail.com>

On Fri, Dec 22, 2023 at 09:46:33PM -0300, Luiz Angelo Daros de Luca wrote:
> The binding docs requires for SMI-connected devices that the switch
> must have a child node named "mdio" and with a compatible string of
> "realtek,smi-mdio". Meanwile, for MDIO-connected switches, the binding
> docs only requires a child node named "mdio".
> 
> This patch changes the driver to use the common denominator for both
> interfaces, looking for the MDIO node by name, ignoring the compatible
> string.
> 
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---

Reviewed-by: Vladimir Oltean <olteanv@gmail.com>

