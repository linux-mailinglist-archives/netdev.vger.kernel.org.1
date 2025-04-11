Return-Path: <netdev+bounces-181505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E08A85412
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2FD04A009C
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 06:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C722527CCC7;
	Fri, 11 Apr 2025 06:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="l55ocSx2";
	dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b="46bCdNpf"
X-Original-To: netdev@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4162D367;
	Fri, 11 Apr 2025 06:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744352676; cv=pass; b=Gsus6rBYrKU2++MlusjOWmoVlu0doFvM8a9flZOTuLCuzRKf0qP2xOcPyrNm8DSSNJ35jDe/po5PcDXD1HejhopkEUDtE6LGXf6BwaB61CjKdzYeAdxN5y3D19nZFBB82l/CClhLg4r88zQ4BBi6/PPmPOKWRPLaq/uuR1Z2VyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744352676; c=relaxed/simple;
	bh=d2mubTFJ9Jx4DL5YGmhz/VPRUAIA2O3MS5/h7Kif+Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fAR6c6cp1cotYtXEkxZ+6O17hEYoidFT7xSAY6s0zF8BV45VFMk7ktLfE4dsEuWUS75r67AbiPLg+b9c5SHYbAyhDYdoAsSCMaPsNdQYLBR7BuhIm/NB/R0uNeYebsQHb+W+OzB/i/P4ktV6MBZaLOQXKh2UtKAx4nedkcSp9f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de; spf=pass smtp.mailfrom=a98shuttle.de; dkim=pass (2048-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=l55ocSx2; dkim=permerror (0-bit key) header.d=fossekall.de header.i=@fossekall.de header.b=46bCdNpf; arc=pass smtp.client-ip=85.215.255.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fossekall.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=a98shuttle.de
ARC-Seal: i=1; a=rsa-sha256; t=1744352669; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mnZvPLknnS52ifaS5LViwU60x9fHICIK3NdjphLl6vk6WRADy8a+87j0HPLIaNhcbh
    wjhLRwKMpiNXdL/6wMJNFxGAws+kLQFy/ZPzuWCrJHq0joAAw/xtO8RaZugGp8dQwMEl
    IYn7cAm4JOzpxvpJQ8sVuH9xpWxceLJIJhjAAMttDI2ffMUKBlCKnIZJuYbHH9WJc5i9
    iBA3GfFNw3Uni0ixTHhHLTn91PGxQFhvY2lJZLApVr9U8iTQ9RM8OCadIcMB7BlOxb0M
    cjYzhbHG3LVhxAOZYKToSZhnKctziIj4K1fDP4CPORVvfBZPJkQgiM9ZgdyUShc/7+ti
    f2ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352669;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gb5I/mWgjpjIabsaRvpx/HiGJaPWsPrCBoI8IElSb8M=;
    b=HME4gGxBlVSKB7696YoMGbl0rKKmqxz5kfh37cCI7spLWrr1WvnpD6DRACF9LA+dyU
    /ncjV8hdSy+pd5vzll5MrsMvQdq21851CmdpKmYDSuDBqHYTpTkqSs/XtHmrfmey/+s+
    YYtwclpo8LstvcZ4GJICb7sZ95fuj7VI3Rwnx5rHYxboNWUJ7FLh72JpxwLyw3XgvPhs
    N8kCahtx0DPvuhRoFGh7gTpXc8WXWCyOBllGNxDvVZmizKaG5IvukyqA1ZK79Fx78Jca
    Kz2niKKbCdHYSwkbN4chsEcMLKD+P4/FZewPYSI91r7LDycoopkp/CmT8s88TS4QdHyT
    k9XQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1744352669;
    s=strato-dkim-0002; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gb5I/mWgjpjIabsaRvpx/HiGJaPWsPrCBoI8IElSb8M=;
    b=l55ocSx2NBzJaOD81lU3u4xNnpMKQK75zWj5xPf80WyQdjhLctB4v5B1fQZP+3It1x
    fzCFA0mGKf4LWdqlwKjEE177KeH29rG7iCukcTT5ZTSjbZWZZR3heh9uinpRJsyle3uH
    UECqZS3Y1/VkBsJs61yYoKO5iqovDm4gjrsr/1hfrCJdVNDvk+uvZ+ZrQkBrNSIxq91P
    aCDwEvjgDpmb/QcKqkAscOvDizO8iVbhYVt88Ps9goADkF/HM5cJPzPMd6/vmVNb7tCV
    peq20MNsdTHw+rQ6v8i8L04wC1Cad8xYhXFYoMZURemxA0kCQRxvaClQhOD4iIjpb27I
    iR3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1744352669;
    s=strato-dkim-0003; d=fossekall.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=gb5I/mWgjpjIabsaRvpx/HiGJaPWsPrCBoI8IElSb8M=;
    b=46bCdNpfny6xx8FFhPd2HYQhOzavWgM6DZynhiAeoDE5iCqNFrsJqhjnoV3Ie9GLBx
    rplpd0sKvtt6jl+iD2AQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBdao6FTL4AJcMdm+lap4JEHkzok9eyEg=="
Received: from aerfugl
    by smtp.strato.de (RZmta 51.3.0 AUTH)
    with ESMTPSA id f28b3513B6OTHaY
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 11 Apr 2025 08:24:29 +0200 (CEST)
Received: from koltrast.home ([192.168.1.27] helo=a98shuttle.de)
	by aerfugl with smtp (Exim 4.96)
	(envelope-from <michael@a98shuttle.de>)
	id 1u37oS-0000MY-1N;
	Fri, 11 Apr 2025 08:24:28 +0200
Received: (nullmailer pid 8854 invoked by uid 502);
	Fri, 11 Apr 2025 06:24:28 -0000
From: Michael Klein <michael@fossekall.de>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Michael Klein <michael@fossekall.de>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [net-next v6 0/4] net: phy: realtek: Add support for PHY LEDs on
Date: Fri, 11 Apr 2025 08:24:22 +0200
Message-Id: <20250411062426.8820-1-michael@fossekall.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

Changes in V6:
- fix macro definition order (patch 1)
- introduce two more register defines (patch 2)

Changes in V5:
- Split cleanup patch and improve code formatting

Changes in V4:
- Change (!ret) to (ret == 0)
- Replace set_bit() by __set_bit()

Changes in V3:
- move definition of rtl8211e_read_ext_page() to patch 2
- Wrap overlong lines

Changes in V2:
- Designate to net-next
- Add ExtPage access cleanup patch as suggested by Andrew Lunn

Michael Klein (4):
  net: phy: realtek: Group RTL82* macro definitions
  net: phy: realtek: Clean up RTL8211E ExtPage access
  net: phy: realtek: use __set_bit() in rtl8211f_led_hw_control_get()
  net: phy: realtek: Add support for PHY LEDs on RTL8211E

 drivers/net/phy/realtek/realtek_main.c | 204 ++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 41 deletions(-)

-- 
2.39.5


