Return-Path: <netdev+bounces-225450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8715EB93AC3
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 02:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DE32A341E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED14339A8;
	Tue, 23 Sep 2025 00:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZWq2tmG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68D91D554;
	Tue, 23 Sep 2025 00:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758586769; cv=none; b=MnKK1tEuJ3wyxtj7uZmky9eY+VM3ZF8UGhviTWi8KVlHuMEL7jMLL52rMwaetC1C2+qCcxzePz8hAzyYxnF32OnO0ZLu/50/0KmGxZieV2GVbaStKOAJL6wIeE4t9B48VQcE6OsIQa8CJrIVjmLCUrl9iCAzlgZXqEykCCd2kMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758586769; c=relaxed/simple;
	bh=avXcu1JOOmx2L0dFaN/r7IEbiHNrmXV9FdhshyoeNBQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cn2N9ThSeSSVn5bMVovt9PlalR9ffngiNoR6hOHwPQ+QHEGTeF0NIV/y1EaOJ1LxzpRc3v6ap0Zmu73QaItpyOnHLQt2DHUbXcJKoNK/0d7n3XV0NvXaoeqsXK1lY9sg2DoP6Fv2aX2CvuWkHaFiXqhFiQIdHX+VWudDDlQbNBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZWq2tmG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C56E9C4CEF0;
	Tue, 23 Sep 2025 00:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758586768;
	bh=avXcu1JOOmx2L0dFaN/r7IEbiHNrmXV9FdhshyoeNBQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CZWq2tmGe/4BvteT5MDNw6fsHJwysOXUttrZnl5ZvgYmvKbWuMFRKkDequr8zKaKn
	 TSFyAjrYvYiza0ILJxK14jMF7ZrkoQQr1SDcgE6iLYjBF8K3tVbZ/YhGMJmgEyUeN+
	 OeVCglnXYM7NUBUUed5kK0SC3odLCaHLOUq2fDGoqwWG7g+naeOZ1xmwCt/rnZ+WdW
	 2lI2LYJnAbdX01Psp55URDpM8Ei5irUAtJfQFCXnqIYOmj0i1ZjwXLoLxYQF4GMimc
	 LGJfgZ47wWTQGgHOgnoa1qeDbPacJBRKkFEOsabmNq7CsIed7QG/dCLquo5Ajy+f1e
	 Rv2OZGSDsCAYg==
Date: Mon, 22 Sep 2025 17:19:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, linux-can@vger.kernel.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net 0/10] pull-request: can 2025-09-22
Message-ID: <20250922171926.63ec8518@kernel.org>
In-Reply-To: <20250922100913.392916-1-mkl@pengutronix.de>
References: <20250922100913.392916-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 22 Sep 2025 12:07:30 +0200 Marc Kleine-Budde wrote:
> Stefan M=C3=A4tje (3):
>       can: esd_usb: Fix not detecting version reply in probe routine
>       can: esd_usb: Fix handling of TX context objects
>       can: esd_usb: Add watermark handling for TX jobs

I have mixed feelings about these. Could you resend the PR for just=20
the first 7 ASAP? Feel free to also send another with the (fixed) esd=20
patches but whether those reach 6.17 final or not will depend on
whether we can review them in time..

