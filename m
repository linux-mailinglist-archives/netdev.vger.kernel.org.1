Return-Path: <netdev+bounces-149872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E979E7DDA
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:55:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CFE16168C
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D717C2C9;
	Sat,  7 Dec 2024 01:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MDSKl1io"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BE34A24;
	Sat,  7 Dec 2024 01:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536542; cv=none; b=n8p7s8Eym/WTtLMWXDTOW8zamIX9KC0QVKQHurItXAm618BsPnDDnnY8WahB7rh6KeL7UGekqBYmoVmniB2k4b+xgqPnwvLG7ZTW7opGoB2rms/VyoYlFylcAFFfRg1WZlFjBFVRUL9wWOuwN4xq1qPXOyov4VMWXxGKpLjHZro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536542; c=relaxed/simple;
	bh=WJ7p03UAhGBbeH5VsLF8GFV4wbIeBicMt/KdoTSC+Zg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QG9XrlJFglQ/GmenaXJll65zFt6+Y7J22uCAGjEQHvuyMDtKTlQLNWsuG3Np4iCV6ELlFPiDI7IQPmYI/IbhSvoGgN+gmto7k99mZOfcIkpnvenYVYOunCFWGmWKwX1pMBafwAlS6Hpf2VbyYtH/k2T2QRrrFO0RMUkMGshxLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MDSKl1io; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD8FC4CED1;
	Sat,  7 Dec 2024 01:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733536541;
	bh=WJ7p03UAhGBbeH5VsLF8GFV4wbIeBicMt/KdoTSC+Zg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MDSKl1ioxROw1yHxVWFqiEUFQQNwxf363ZajahXXGQxtVibR+lY5mA3rziuOFkgKJ
	 IdMbUkBBqtVP/vTyOUwR1xG0Y1uiiumkELJ0ZcohOZTLt8iinInBSrUmazf36pXxa1
	 SDP80269K63VaLg/UlMNMzyvJ6lOH6gAKROIGVw5gdS9qQk5IYF6MvUx4pYRPEzJM4
	 Py2XKYYMbxjI3xyclQoTYprDiJWrXG2h1NBi9lSnM7m+WPkMMvwC3m7+jebC/PSx5E
	 MpulLRFFNc6B1tsOUXpcBDj5DK8MRmZTZcjila5UrGjuuM1P78LUHix71FzgYOn1xj
	 NoQcmwxN2c+ew==
Date: Fri, 6 Dec 2024 17:55:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Woojung Huh
 <woojung.huh@microchip.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, UNGLinuxDriver@microchip.com, Phil Elwell
 <phil@raspberrypi.org>
Subject: Re: [PATCH net-next v2 00/21] lan78xx: Preparations for PHYlink
Message-ID: <20241206175540.284c6351@kernel.org>
In-Reply-To: <20241204084142.1152696-1-o.rempel@pengutronix.de>
References: <20241204084142.1152696-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 09:41:32 +0100 Oleksij Rempel wrote:
> Subject: [PATCH net-next v2 00/21] lan78xx: Preparations for PHYlink

Be careful when reusing cover letters, the 21 here makes patchwork think
the series will have 21 patches, even tho patches say /10.

