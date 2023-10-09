Return-Path: <netdev+bounces-39155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CFC7BE3DF
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638601C209DD
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 795BD35892;
	Mon,  9 Oct 2023 15:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quXvC67a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E77493;
	Mon,  9 Oct 2023 15:06:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1B9C433C7;
	Mon,  9 Oct 2023 15:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696864007;
	bh=Mvl8gmMUGBGCZa2+BmF3BHc0Ktp7URfkGdtj2C5AfQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=quXvC67axl7GtJTGnQ+A38R+W+N0CdCyMvV+QOKYW6YMMjK8eHvjtnJIIkDljGNDZ
	 jNHSvIrlT+ZDsxEUo+Lv8y1fTNYDDD5XGgOmkLrSUdfXSx7QbFNXpmVF5E3kQycapg
	 qHq1GxUvMMFur9nqe/rTweSWIHQeN6UQhkMmaWfA6sX976l4A/txWbMg3FjcXvL3qE
	 YVPFdT2sfNdQ1SyiWj0E3/NY48pM8yg+D7V3FFechGbU6gKx2+UX9BjkKRzF2zPyCN
	 sbb3qG2GjnB6qc2Hx3OYDOZs/Gyt88in4KNipyZw1GSQyBPsM3bNkotUi9xgEhudJj
	 CbOoV3aErUiEQ==
Date: Mon, 9 Oct 2023 08:06:46 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Pedro Tammela <pctammela@mojatatu.com>, markovicbudimir@gmail.com
Cc: Christian Theune <ct@flyingcircus.io>, stable@vger.kernel.org,
 netdev@vger.kernel.org, Linux regressions mailing list
 <regressions@lists.linux.dev>, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [REGRESSION] Userland interface breaks due to hard HFSC_FSC
 requirement
Message-ID: <20231009080646.60ce9920@kernel.org>
In-Reply-To: <0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
References: <297D84E3-736E-4AB4-B825-264279E2043C@flyingcircus.io>
	<065a0dac-499f-7375-ddb4-1800e8ef61d1@mojatatu.com>
	<0BC2C22C-F9AA-4B13-905D-FE32F41BDA8A@flyingcircus.io>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 7 Oct 2023 06:10:42 +0200 Christian Theune wrote:
> The idea of not bricking your system by upgrading the Linux kernel
> seems to apply here. IMHO the change could maybe done in a way that
> keeps the system running but informs the user that something isn=E2=80=99t
> working as intended?

Herm, how did we get this far without CCing the author of the patch.
Adding Budimir.

Pedro, Budimir, any idea what the original bug was? There isn't much
info in the commit message.

