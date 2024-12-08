Return-Path: <netdev+bounces-149955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4054D9E8324
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 03:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 017C628171B
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 02:31:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40495134BD;
	Sun,  8 Dec 2024 02:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gS7p2sip"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB05BA4B
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733625109; cv=none; b=lY0pI8CghMhsEb1byuEgdsVawPR1KJ9uqqUOycE/9zuJsRLSMOLFlaV0KraQDrdE76w7J1EwE3POYu54QsKCbe6HwmhHc7RfFlZl3wfYZkZLjxANGFZsHCjCm5s/ph4ffCI+b+p7fwgtS85T6lGxkeVVuhCR41USFUdlpMV7NYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733625109; c=relaxed/simple;
	bh=CWnz1TQWxko2o0QN9VUUQ1Ut1ooI8/nQpkIANs0xLEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eY4zVo+MRNmPWYyS1Cr/v54KU2iXQ0G3IOIyBchLm+nmJ6vRKWBqWWNnORLTVqp8Jcd0xvFiSFitv3bob+ie1I3eB3YUBQ9WiMChxpipPENi/yS5E52UM6ForQe2CAWpN70+6COko0fpYN7tkuvnP52lcU41k/vBgjmVFGuwVYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gS7p2sip; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F62C4CECD;
	Sun,  8 Dec 2024 02:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733625108;
	bh=CWnz1TQWxko2o0QN9VUUQ1Ut1ooI8/nQpkIANs0xLEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gS7p2sipM/qNLrQVvbFNdEsDYo3h6MfhZwFNV6oR9O858Rphyfbq7PuY+BymvL48n
	 sgiGWxH5h+sQBZkPG7F10DvL2bASvJkdQi7XEPOV147sONPoUnRgghmU490+fo9v14
	 8QoTqFZDElRHfwe5wsiGFWNpyv6J0iFosmbHgoXW1jS9Xa5fT/8v1Y/DAvHYUx7MGf
	 BBRsNrFifBgKQJ8W+x+jaa4aTor7c7Js4gLesa59dceLznpgIEessBf2UtP5f7BPKC
	 e+5WwzLFVJSF2pbmfRXtqMZlBtaGSB8GZdAuxUB33s1cVInLE6snLsG7b9NYdq91Ne
	 VQfbwgynRYM7w==
Date: Sat, 7 Dec 2024 18:31:47 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anumula Murali Mohan Reddy <anumula@chelsio.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 pabeni@redhat.com, bharat@chelsio.com
Subject: Re: [PATCH net-next] cxgb4: add driver support for FW_CLIP2_CMD
Message-ID: <20241207183147.03f16386@kernel.org>
In-Reply-To: <20241204135416.14041-1-anumula@chelsio.com>
References: <20241204135416.14041-1-anumula@chelsio.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  4 Dec 2024 19:24:16 +0530 Anumula Murali Mohan Reddy wrote:
> Query firmware for FW_CLIP2_CMD support and enable it. FW_CLIP2_CMD
> will be used for setting LIP mask for the corresponding entry in the
> CLIP table. If no LIP mask is specified, a default value of ~0 is
> written for mask.

I don't know what LIP mask or CLIP table are, how they are used, 
and most importantly what the impact of this change is to the user.
Please write a proper commit message.
-- 
pw-bot: cr

