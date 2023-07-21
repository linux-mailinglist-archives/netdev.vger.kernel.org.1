Return-Path: <netdev+bounces-19757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02EFE75C1F5
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 10:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19F2F28182E
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 08:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3B1014F65;
	Fri, 21 Jul 2023 08:47:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB56110FF;
	Fri, 21 Jul 2023 08:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABA2FC433C9;
	Fri, 21 Jul 2023 08:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689929238;
	bh=FEKthsGCfhaEvehaNkfvwG3DLwk8goiFrf9dyCAABYc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=oV/1WyP3eeXWRIvqYmFo9pbkUYA88uMIYF/vfFmzfqy+AT0Y81JajLaPh46YYjth9
	 T2u7rr3ngVPRMdkrNkOAzz1PKNELYK+rcsL0PcliUF4YbBQURoPpS256yFcBRO5lE6
	 t+a9F25kZcZeWCWy0KGpy03UROHpL2kLbnapHFanwnYX0C9DuXhtBFs08pRAH9Q+xH
	 IXuiniBG3AHfBRLUsO49RdvTxk8tpnz4VJHWNz+Qq5IEs9stME+SRAG3QHhCmtgQyT
	 cveDUKwMPP9UU/uC07PRzp7p9mcb8VdizvzhCx3z5dyKWnOozLDf4qq5QfAVf5Pu5n
	 BcbAARG5CcXFw==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Colin Ian King <colin.i.king@gmail.com>, Magnus Karlsson
 <magnus.karlsson@intel.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>,
 Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kselftest@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] selftests/xsk: Fix spelling mistake "querrying"
 -> "querying"
In-Reply-To: <20230720104815.123146-1-colin.i.king@gmail.com>
References: <20230720104815.123146-1-colin.i.king@gmail.com>
Date: Fri, 21 Jul 2023 10:47:15 +0200
Message-ID: <87sf9hfy7g.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Colin Ian King <colin.i.king@gmail.com> writes:

> There is a spelling mistake in an error message. Fix it.
>
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>

