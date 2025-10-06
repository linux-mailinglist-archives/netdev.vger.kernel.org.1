Return-Path: <netdev+bounces-228015-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AAFEBBF15A
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 21:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 124314E44F0
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB7526CE36;
	Mon,  6 Oct 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/AF4wwD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD94A1E;
	Mon,  6 Oct 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759778588; cv=none; b=ovtC9ftZhWucjThU6gk/J02GZzmfIOYZZ2bLmKmj+FIJxXydEahIEh1GDZy6BQJVB/5ISi9+FpipdH7WFlRJf5eEQ1HPTH8bt3OOhgXq7+HBVuIgyVCYyU9kzZ3VdlDoZ8ZGGSJGB3fVgompoOZRNNidda0Cm2kG2T1foczjRaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759778588; c=relaxed/simple;
	bh=2Gn5ptTvqMrFO9ipwge9JydBRotriMi4oXsOgOqd/T8=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ISxtAW87bTBmfLo8T2ET2s1RdGvXq+7xjKuq8rX0twDRqgG2u0NfzlrZ9WTerPqSf9BI3UYKriYdnEKlCiEdQFDzjzLn6N+B4OEsMitrUyCtoOPUyqgFqun7Iv6BNhs5ochkawWHfl6d+UMIDVTW5D9RADTNLEBHyySVbrruMB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E/AF4wwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F348EC4CEF5;
	Mon,  6 Oct 2025 19:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759778588;
	bh=2Gn5ptTvqMrFO9ipwge9JydBRotriMi4oXsOgOqd/T8=;
	h=Date:From:To:Subject:From;
	b=E/AF4wwD02jJJ9p+I7Dc/uwu6OVHP9M98C3LipBlXvTP9EQ2/VWBpVblEb1rcXlnl
	 IVEz8tMvxjwsRBIP9CuLOTPD1+9hSjH0iCW7KDjQwXqsbLLs84JZBhCRmKdC+j2oJl
	 +agMAMFQVbQg1hB+LkBroODAJr/Ap80oib0uwxanpSSwhpjbCn+3IFP/3HKUr3Ok2z
	 FoMjAWGjVYK5YGwYoJ2sFv6iGPA1ByIMaFwAoFaTpDVaYdTRQ2752qIiOmuQMfu9Nk
	 bb6qWitSK8/f9D3b+QTRmD+EZRQWAE8NBDLsvszKfOQEHw+o7D6peavH1C3W+v7FTa
	 WKwVfEIloWL5w==
Date: Mon, 6 Oct 2025 12:23:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: [ANN] netdev call - Oct 7th
Message-ID: <20251006122307.2bc93c9c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join

No agenda at this stage. Please reply with suggestions, if no topics
are proposed before the meeting we'll cancel.

