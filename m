Return-Path: <netdev+bounces-115917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFD948645
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 01:42:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B13284547
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 23:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F161B15ECF8;
	Mon,  5 Aug 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I3M83ikP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6179273FD;
	Mon,  5 Aug 2024 23:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722901342; cv=none; b=OJNHyz4SOCLvsNKs93bWc2l/XSgpovsq6zH07XklwogeRnISTS0vH14MY7QASWH90tI9BwEGV7gyp5bgoqZo0g/clAl4uBt/h43MMxR9Nao58DyaOt9kpGsfTNE35/W/Fwh11cTA+DiKDFfq1Vk2rkg1SyK5Fm5d9YHq0zcUiI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722901342; c=relaxed/simple;
	bh=G/COHNNxGTwTS8EumnD5M8lzCmJxcbhA3j3Mp4sbq0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQkUeocAwHXxKgSwoajv6PT9DeTsFebd4jV5B5ER9ohLMkxvd82WHQc2cWdR3KoZwW7Pl7oQrsfboaBj0NnhorNhvirbcQYGKszf4P8yu+/7imTvp7GeSsTKbMo4y/uUSIGQ+C8Kv5O2kcllwnHYEApamgVpuT5uSioYUbLrvAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I3M83ikP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957CEC32782;
	Mon,  5 Aug 2024 23:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722901342;
	bh=G/COHNNxGTwTS8EumnD5M8lzCmJxcbhA3j3Mp4sbq0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I3M83ikPp9B/cv0IcgPvs9xmF7faQfOvVtKdUC2EN+sg4JY9gVVYq69wkg8cR9OQh
	 7laDCbutZJzmcykLr6pE/GQMTTIg1/WgWcbrOM78LAyc6krE0OKL5vceMbCZ+5UeE1
	 S9Jp85UhoJrxMYyUJqJoMng8OCbUY5Bw06nFFHVPT4majZXxA04DzlShhlFQMJ/uPX
	 9HvfVSogcXH/ijv9zR7Asrz4xyry9U6bUQgB4E7Tao6z3NB/hnfHmg14fykYnPx1IO
	 0GfoOoqWgO8Nt77xiphxleccFHR2mcYPNy1YW4um00mKNfo8ShwWWAdawIOgUGy+Da
	 vzhSelSJW1/3g==
Date: Mon, 5 Aug 2024 16:42:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, arinc.unal@arinc9.com, daniel@makrotopia.org,
 dqfext@gmail.com, sean.wang@mediatek.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 lorenzo.bianconi83@gmail.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, upstream@airoha.com
Subject: Re: [PATCH v2 net-next 0/2] Add support for EN7581 to mt7530 driver
Message-ID: <20240805164220.3d6bc554@kernel.org>
In-Reply-To: <cover.1722496682.git.lorenzo@kernel.org>
References: <cover.1722496682.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Aug 2024 09:35:10 +0200 Lorenzo Bianconi wrote:
> Add EN7581 support to MT7530 DSA driver.
> 
> Changes since v1:
> - get rid of mac_port_config callback for EN7581
> - introduce en7581_mac_port_get_caps callback
> - introduce MT753X_FORCE_MODE(id) macro
> - fix compatible property in mt7530.yaml

Looks like this got applied as 3608d6aca5e7 ("Merge branch 'dsa-en7581'
into main"). I think due to some script misbehavior it has the wrong
cover letter on the merge, but the code matches this series.

Thanks!

