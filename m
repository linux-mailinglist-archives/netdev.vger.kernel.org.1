Return-Path: <netdev+bounces-118498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E24C8951CD1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 16:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F2C42817DC
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 14:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E870A1B3740;
	Wed, 14 Aug 2024 14:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ihrFfsnD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4BC813C684
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 14:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723644839; cv=none; b=GkkZB2IQqgxP8NGXDwq+l6rm5Vq9OK5Jw5lzhWSDhtPgp1zgq86s5z7wSYSfCTFKSwrNYRnmp8f9c4V4qldNh6WmW3d3LGvUvVDw4J/S0Ei+qghbkBP0ZLd3Bbro2QBQaseQAPE117X7kXInEJ3Xydjb2xNo7aITw66epb+0sjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723644839; c=relaxed/simple;
	bh=8r4vzaZ12nCmZGwfUvRigt1e3ycid2U4JYxr7KavtDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PODSeE+9XUJZi1cWGZySS9BVfYvkMo87EWPUHTiIWigSva0xPG+W4no8tiusar4fvdytPpo9BhobAxIQH6POJZ31CtPbyiQQCqk4gxyqyiefAV58AkBUbFbSxyoBHaIhMQHtV5Ewpwu3ufBZmJAAwnIojnAyaQ9jl0VXIGRkDP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ihrFfsnD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B280C116B1;
	Wed, 14 Aug 2024 14:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723644838;
	bh=8r4vzaZ12nCmZGwfUvRigt1e3ycid2U4JYxr7KavtDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ihrFfsnDHXiipoELBIb2w6OKKxrZQEGyXnAWtatb7HQzxMTAy2Amb6DA0KEWRmHUu
	 mRztfCJGwHr96m/qka00DMv6lhXvME+ddhutBK2ySjzeFCQQsLZHuycSBWkezYXENq
	 kLHxaklocjNAkjarqRvhYMs5WAUGTCfKOQC+JviSYyvTdrbPVL7mgMJUoOY1s1DjEk
	 EsMDotxAAxTpCAPvf04h22Rutcb2PyLouaS1EWmUeF46931NVemLroNznhjQH2yOaj
	 IqVj+NHaiiS5Z4/wNYZALVzvVQe0XF07Kxh5uxMTMuN+B3RkxPWL6CsbCwp/oZxENK
	 kSg89SKSw64VA==
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A710A14AE016; Wed, 14 Aug 2024 16:13:55 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>
To: =?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?= <tcm4095@gmail.com>,
 stephen@networkplumber.org
Cc: netdev@vger.kernel.org, =?utf-8?B?TMawxqFuZyBWaeG7h3QgSG/DoG5n?=
 <tcm4095@gmail.com>
Subject: Re: [PATCH iproute2 v2 2/2] tc-cake: reformat
In-Reply-To: <20240812044234.3570-2-tcm4095@gmail.com>
References: <20240812044234.3570-1-tcm4095@gmail.com>
 <20240812044234.3570-2-tcm4095@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 14 Aug 2024 16:13:55 +0200
Message-ID: <87jzgjchuk.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng <tcm4095@gmail.com> writes:

> Reformat tc-cake to use man format (nroff) instead of pre-formatting.
>
> Signed-off-by: L=C6=B0=C6=A1ng Vi=E1=BB=87t Ho=C3=A0ng <tcm4095@gmail.com>

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@kernel.org>

