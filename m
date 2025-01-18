Return-Path: <netdev+bounces-159524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BB06A15B0A
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 03:21:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBF8C188BCD0
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7112E200A3;
	Sat, 18 Jan 2025 02:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmslRw2Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A1B23CE;
	Sat, 18 Jan 2025 02:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737166861; cv=none; b=kJB5k2PXwnXmvjLfKjX0Vs2i+1RO5XsK/9OmXjVoUvApmIhuIeKrcMyN7Pn+umE/S4KGKdOI9KG3IAL6UXsxfipbT7roftXkiYo3JlUftWqJ5LRdBg6Q2azIlb7qobqib7fi49TcxgfuNJoBAAVm+soOsP0meoUL2fqKzzmhgB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737166861; c=relaxed/simple;
	bh=7xmog2I/sZ4sNHKLMztjs5oaWGJWj0xuoWv++R8BrYY=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=LtCrKTyGKIDcADoe/ec+Bl7A93aMgDUkzAd3/IzGx9FpEBELntHS86aTOExdfSevzy//v/aW+6FWLasyvZwAF2LidEdgyPGH0SRZRN8i399VDF+RWq1XlKN5UUkB9PcKsrA1q0p4Q18Hueukc9WyuE/LcUKFGYonjE5y13svfiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmslRw2Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82647C4CEDD;
	Sat, 18 Jan 2025 02:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737166860;
	bh=7xmog2I/sZ4sNHKLMztjs5oaWGJWj0xuoWv++R8BrYY=;
	h=Date:From:To:Subject:From;
	b=qmslRw2Q/VQdHm8JuGK9u/l7wAi8eNF16TpvdT+q7QawDzKrL9TrdC0zxou8Ini/S
	 b25F0nVOV3N7KiX9k7qxBFHTXklcGM6XG/zgvGfr9ZXgKtynIxdvgPBB+w3lC/Y3fG
	 QVCbIWGdp+mCByLXLNOhA5SG+RHkwv277CdHJzpvQ2sXnCBxhvXW7ycE2B6qF3mjgx
	 3Ly/evEqfVFdkVeRgllUKcp9+Zi2fNmgsH6cwiWLd53QXGTxkAa8Bu/PRbjUKomoB6
	 srQogF3ypi4OKOnqAFApZWYmSrCFYOeV2CNL3bzV8al6piIaerErEPpOGd/oGpaT/V
	 SVyq8Vz+OfLcw==
Date: Fri, 17 Jan 2025 18:20:59 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20250117182059.7ce1196f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus is expected to cut final v6.13 this weekend, so let's stop
queuing -next material already. We'll cancel the announcement
in case there's an -rc8. Otherwise net-next will reopen on Feb 3rd.

If you have a fix for net-next do use net-next in the subject.
And generate net patches against net.
net-next is "closed" but we will apply fixes until the PR is ready.

