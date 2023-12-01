Return-Path: <netdev+bounces-52803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7449B800413
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4EFAB20FCE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:41:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4985848E;
	Fri,  1 Dec 2023 06:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CDfX/sza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDDAE59529;
	Fri,  1 Dec 2023 06:41:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8670C433C7;
	Fri,  1 Dec 2023 06:41:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701412896;
	bh=wBxRNgktqMi4buSak8ExlObqOhD8lf2YOCeG4b9vF2E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CDfX/szat7TYKUyWdJ87XILl5vFTSxT6f5q1oUgSgxwS/JcQu7kDqjzs9HbN2RrBj
	 Q4PnH8BnlgFQSyqFjv1hc+qlPiSLEQK65b4zaT1XJSA8p5zuwAnL9EFzjn54kPyjVh
	 rfGbOpTGtPGuyGN0d8Msjq5QhBAhGDhiaJRpXMqMh8JUsY/jiMgXz7l0J8npoBvljh
	 V518EprIKwKqRoyKjG2Q3nKMjcOF6XRC3ocouCwaO486pk2hOH9hiVfQ/nmu35ngK9
	 wxjapoTCEOUa3X+LLQyBo0frJgFFUCSz4Cd2ynPua3XjamiNbd9vDGRWdn8NK4jjpE
	 B77/VUT25b+yw==
Date: Thu, 30 Nov 2023 22:41:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski
 <akiyano@amazon.com>, David Arinzon <darinzon@amazon.com>, Noam Dagan
 <ndagan@amazon.com>, Saeed Bishara <saeedb@amazon.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: ena: replace deprecated strncpy with strscpy
Message-ID: <20231130224134.73652d71@kernel.org>
In-Reply-To: <170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
References: <20231005-strncpy-drivers-net-ethernet-amazon-ena-ena_netdev-c-v1-1-ba4879974160@google.com>
	<170138158571.3648714.3841499997574845448.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 13:59:48 -0800 Kees Cook wrote:
> [1/1] net: ena: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/111f5a435d33

Again, please drop, Arthur requested for the commit message
to be changed.

