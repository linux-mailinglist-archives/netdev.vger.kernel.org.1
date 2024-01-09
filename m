Return-Path: <netdev+bounces-62623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4FF582839E
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 11:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D580C1C23BD7
	for <lists+netdev@lfdr.de>; Tue,  9 Jan 2024 10:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD6535EE5;
	Tue,  9 Jan 2024 10:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vj/slGvb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC031A7E;
	Tue,  9 Jan 2024 10:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50eabd1c701so3303501e87.3;
        Tue, 09 Jan 2024 02:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704794608; x=1705399408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Y1yFnGwCxaJ38SAnsqfHX0zi0fQTzVhh1Q60oTmi8w=;
        b=Vj/slGvbpKPmbdMZGFIqQHfO3GxfCvqhBkpVHCkBlId0Kt86IhWO8GHrbMOK4BuLRE
         Qq6kEOWPQrFd1RmeBhKVdFPYKoKRtXsLJtd0EwnkO6rliN74ppmigwTn9wfWdIO7bbq6
         a76NATtxQeUqAJsoWf4L3l1lzb4hfEdVdHKsxb7V/3LWt1Y/wX9oODDR0iXbywixr4IR
         qainYqZKcyuHuHi5JqI3EHPhO2++frMWv0ASvgMVRmcd6dr0xUSh9CRoltYQKQTTnKQK
         Lx6luO6hDEYEA89I/MuiBRXnKCEMiJg/7uKw5XgK13Nn6f/tAf1vOYugjTBJLfCkbJ25
         qbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704794608; x=1705399408;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3Y1yFnGwCxaJ38SAnsqfHX0zi0fQTzVhh1Q60oTmi8w=;
        b=S04UNIgYgg3+urITQyg5LHzlf7RfV/a4b1DAYRRQo/plr/NwAb9IY1TL8q7VAERIv/
         lBjbCce6jclUO20MIIsiMUF9WJjKBlhqLdUpKZAwM7Hp4JyWffOU3KujMaQZZDXb0Sgf
         CwuYOoGR22LBbLOS/shNgp+Apy5XUpuskysjciccQ6o4JDuXXwObzGNjFIYjfPA3Fj+l
         4rIHIJyZEeuOqF1KjrSr0GzEEgU2b/qNNThoA8hZrWx4T7YQEAUrJZ1XWdKMyQhRZCMI
         7IY5Y8N4n5axO7rnqkfmahR5hV97yyx/j9XSGH3Odk05HbSGa6u5IIMaLadJERwM8C/w
         r1Wg==
X-Gm-Message-State: AOJu0YwzChWViz8iKzvhncLXGw7cZza5P9WbWLw7TnPL+Bmv50RM0KaV
	p2mbfkg38OPEplefS06Fb+6VGYsZmj4=
X-Google-Smtp-Source: AGHT+IELDKUtj3zZFQ4g/uA/k9Dd1nPZ7q9xaP1hCDi7aXAHt6eU1yOMqsoKuchurA11pt/VMNBLFA==
X-Received: by 2002:a19:e016:0:b0:50e:99fc:3b48 with SMTP id x22-20020a19e016000000b0050e99fc3b48mr1967337lfg.34.1704794608101;
        Tue, 09 Jan 2024 02:03:28 -0800 (PST)
Received: from [192.168.26.149] (031011218106.poznan.vectranet.pl. [31.11.218.106])
        by smtp.googlemail.com with ESMTPSA id u23-20020a1709063b9700b00a26af4d96c6sm856945ejf.4.2024.01.09.02.03.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 02:03:27 -0800 (PST)
Message-ID: <bdf7751b-0421-485d-8382-26c084f09d7d@gmail.com>
Date: Tue, 9 Jan 2024 11:03:26 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Subject: Ethernet binding: broken validation parsing of #nvmem-cell-cells ?
To: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Network Development <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Florian Fainelli <f.fainelli@gmail.com>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi,

I'm playing with "dtbs_check" and I stuck on following errors:

arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dtb: ethernet@24000: nvmem-cells: [[9], [0]] is too long
         from schema $id: http://devicetree.org/schemas/net/ethernet-controller.yaml#
arch/arm/boot/dts/broadcom/bcm47094-luxul-xwr-3150-v1.dtb: ethernet-switch@18007000: ports:port@4:nvmem-cells: [[9], [5]] is too long
         from schema $id: http://devicetree.org/schemas/net/dsa/brcm,b53.yaml#


Context:

nvram@1eff0000 {
	compatible = "brcm,nvram";
	reg = <0x1eff0000 0x10000>;

	et0macaddr: et0macaddr {
		#nvmem-cell-cells = <1>;
	};
};

&gmac0 {
	nvmem-cells = <&et0macaddr 0>;
	nvmem-cell-names = "mac-address";
};


The validation error comes from ethernet-controller.yaml which contains:

nvmem-cells:
   maxItems: 1
   description:
     Reference to an nvmem node for the MAC address


If I'm not mistaken <&et0macaddr 0> gets treated as two items.

Can someone tell me what's going on here and help me with solving it,
please? I would expect it to be sth trivial but I can't see any obvious
mistake.

-- 
Rafał Miłecki

