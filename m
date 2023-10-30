Return-Path: <netdev+bounces-45301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 535947DC01A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76C7A1C20AEB
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:56:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F280199BF;
	Mon, 30 Oct 2023 18:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fxBA+dbO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473EB19BA8;
	Mon, 30 Oct 2023 18:56:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86DF8C433C8;
	Mon, 30 Oct 2023 18:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698692167;
	bh=zfAcRGpM6KrH3AASAFPkdWrwC4DVnNmCXJNxrZXU+x0=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=fxBA+dbOQxuP4L+BMvnmXPTQcSgUWuS0VPsZeFLa6lRXGhEnDY2ECTvgabWgp4HaH
	 wDDrwR4Uqlvwj+PHd1pFg9Bl35vYVIErmIHvIT19ZwzuxYJPLMRFVcKbpDlX1YgSne
	 H6t9upXRPoQOBmSVn5Udd7S/Y/zt+L2UvoOuLGCUaPHQbHkcsAc2NScsUZTshjnRLH
	 XZJKFy7WNgpBRu+v+vzgOhZRHvhbvFCBAIs+Ql+r54Oe7hqwTsHxAbnPVv1+ElslSj
	 zoJJqBLgQsxGV46N/o5xYf3oh0hMB0C1zHK1SAq1BRaSdstHe64rwdqY0l0yipYKlN
	 nwNc4RI1XJRlw==
Message-ID: <4ac6b9d1e6dc7859b39fa456cec70fc7.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com> <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
Subject: Re: [PATCH 2/8] dt-bindings: clock: ipq5332: drop the few nss clocks definition
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Conor Dooley <conor+dt@kernel.org>, Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Michael Turquette <mturquette@baylibre.com>, Richard Cochran <richardcochran@gmail.com>, Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
Date: Mon, 30 Oct 2023 11:56:05 -0700
User-Agent: alot/0.10

Quoting Kathiravan Thirumoorthy (2023-10-30 02:47:17)
> gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
> enabled by default and it's RCG is properly configured by bootloader.
>=20
> Some of the NSS clocks needs these clocks to be enabled. To avoid
> these clocks being disabled by clock framework, drop these entries.
>=20
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> ---

Instead of this patch just drop the clks from the table and enable the
clks during probe with register writes.

