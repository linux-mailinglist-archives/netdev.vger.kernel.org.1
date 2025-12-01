Return-Path: <netdev+bounces-243104-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 92277C99872
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 00:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 96A3E344F70
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 23:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 568CB288C34;
	Mon,  1 Dec 2025 23:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eimEgyZd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C6E28725D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 23:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764630451; cv=none; b=DNjKOsIfvIJVFBn6lvFWv3RmDh+v2iYIRYiXFxo34skq2seXQLVCCuzVrS3dbTlmlHwX6U8HEjHj3e/X5g+nlJ3Nfj9EdhVeFbcVvKPjRMLI5bLTfNGlTjksBFAWi/jWzUVd8/LglArQiK8Z8lIG0BfPZUqFo6CSXy/YXqAEnC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764630451; c=relaxed/simple;
	bh=aoupLO/Cmc7kzJqFpK2+jsxfj766QCKn9BTbHcOeH+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o7GtCSehthsRU1F3Y35sGbBRxkSJJJzrjZXwgCtt2Pvj7HvX81n3AUGnOf9Uj2g4nZgiDcPnvFCW1+ZLtDx4I8yOAZNMqCqvgb6xpfkB62pVQQyMKYZUV0iPxux2io13VmeW3z3tWYcL5D1WIbMdxUbsHU94D0DiIM1BcFl9NE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eimEgyZd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFCFC4CEF1;
	Mon,  1 Dec 2025 23:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764630450;
	bh=aoupLO/Cmc7kzJqFpK2+jsxfj766QCKn9BTbHcOeH+g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eimEgyZdn5w2UyRMZ1m0AIWOlU6payeLM5nW/GugUSYUhgQRZlcJ5oniKy+OeB25K
	 dZSgdhT43+Voqz5buma1tlu00tmyu1Y01NkT2GBP6RzcDMCUpYXQ4baJ3VGPwNrd/G
	 Q6s03l9JgcCbcBch/KxxBRC1iYLgjc5wR8wmFoZqTyNhOWvt3IkgwTxLYCrGPFBnqb
	 Uow0Q97AvMKqO9T7UxcwcyRjRv+QUt16dgIxo+4+IBdqv1YlE8ofAdkwSbutrj7FEx
	 YWwZJ/uQp8ikn/FULJm70RI5v67mM+/9GpDn1r5FqUUwVTD8tGS6hMk37togsEiNqa
	 0h+yXbyLkN70A==
Date: Mon, 1 Dec 2025 15:07:29 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH net-next 00/11] wireguard updates for 6.19
Message-ID: <20251201150729.521a927d@kernel.org>
In-Reply-To: <20251201022849.418666-1-Jason@zx2c4.com>
References: <20251201022849.418666-1-Jason@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon,  1 Dec 2025 03:28:38 +0100 Jason A. Donenfeld wrote:
> Please find here Asbj=C3=B8rn's yml series. This has been sitting in my
> testing for the last week or so, since he sent out the latest series,
> and I haven't found any issues so far. Please pull!

Hi Jason! Thanks for the quick turn around! You say "please pull"
did you mean to include a PR in this or should I apply the patches=20
from the list?

