Return-Path: <netdev+bounces-161352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EF81A20D02
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 16:29:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1B201617CE
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 15:29:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64D9A1B425C;
	Tue, 28 Jan 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sia1IRn3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A67218DF86;
	Tue, 28 Jan 2025 15:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738078168; cv=none; b=TZV4QoEiDEPBuXyLV7vNP7fr29yPwEPvmh98K5+HblpSKK1JLpQkyqDps0G4Rz1D3z52JpMZ44XkQmNMVN0DKruqHOtEmSxXikKi6WJYZhj5MSFxJ6DHdjn5XU9wHFiWJAd8wRcaoLYR/g/F8Un8ISn+k9Gbgbj0TQW5DCW5EDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738078168; c=relaxed/simple;
	bh=1U8/Z30rWavkD2NtpZ32euEvb00qgSObdFk+uMvN/xQ=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvuGx+8UehKsX8vWGlA1b/bkLHlxwRoLPzZI3rdt8LBb3rNcFkxUqL2RFdZIgpE2Qcs1yynAvDTO0Xzqq31iOC6ej9FDBgsG5ppoF1j4Jrre9ptxNleV3SYUYO4saERjK+pMEotlApEVHrS2OOMB3oR3ndDXXOV9XVfHqwsnbGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sia1IRn3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 667AFC4CED3;
	Tue, 28 Jan 2025 15:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738078167;
	bh=1U8/Z30rWavkD2NtpZ32euEvb00qgSObdFk+uMvN/xQ=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=sia1IRn3IyCc5q0SoTtlFtWESqWJfughy0dDvbEM/NpNnVuJfxjH+EI8BQ9NNtnlg
	 sB/V4UeunHDalZ0uponnB9JfxPDmGMHokJCCd2mSf5mD3Q7vYGS1Ehjc6Pg/If7R5E
	 kI077wESYFcZu8d9boHBStcVio5q1ahliOufFkw+s17yf8TmQm+fLdc2z4Capymhke
	 SA9QVCnPSbd3Twh+k2eaFiSSEHgjc+1VUqq1HktS5WhInjLEcWCY+951eW/SPLL/dm
	 CAh5+1Gyd+oQui85FRbkXDb2kVxLNB5IxAae6oN9D7zF4h5I7Y8AKDIJAb7EhAF4l7
	 8q7Otv1IUFHPA==
Date: Tue, 28 Jan 2025 07:29:26 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "netdev-driver-reviewers@vger.kernel.org"
 <netdev-driver-reviewers@vger.kernel.org>
Subject: Re: [ANN] netdev call - Jan 27th
Message-ID: <20250128072926.55438024@kernel.org>
In-Reply-To: <20250127075639.19a5ad61@kernel.org>
References: <20250127075639.19a5ad61@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jan 2025 07:56:39 -0800 Jakub Kicinski wrote:
> I'm not aware of any topics so please share some, if nobody
> does we'll cancel.

Canceled..

