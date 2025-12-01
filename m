Return-Path: <netdev+bounces-242865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ED209C9586C
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 02:45:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DD3364E07BB
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 01:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC6C814F9FB;
	Mon,  1 Dec 2025 01:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERixJWId"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8667715687D
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 01:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764553508; cv=none; b=qLIOYgOYGBVMmM4Jbx1BGo0Og9aFwrKlgh6KTwtmNMMbGE9SFPz88s1bNp0fzsqG6iT2gLed0qEcPmos26xs6Kv1trHA8c3ryZG3lAHfLlc0ZfThJIf/00+grjLq+X9bwHaHHvIX4VeZZBtt3xCtexoNS+ckNnSYPqSbL3YT7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764553508; c=relaxed/simple;
	bh=ahoaQvf4WLn8rYeQYQR4WsEK+UL07Ck5NNphqgL90hk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=ZlONKF84ReJGz16/YWFeRYw9pFwNVzS+wZUuv0Pg6OhnZ92VBc2SCDizPJKzakuV+EfvxQ5YTJXHHcJ2EFMHQWdc+jYdJqcyW8TBx2uxbBUqqVJdeA2s7EqefD5RhdK8RDq5I3ukDrWgOL3g4czzls1ECpJ9qYSJ4ty2A710pL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERixJWId; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE636C4CEFB
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 01:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764553504;
	bh=ahoaQvf4WLn8rYeQYQR4WsEK+UL07Ck5NNphqgL90hk=;
	h=Date:From:To:Subject:From;
	b=ERixJWIdKEXBXMHZPigZUp2SYbWW/sHwMdfXQqztCWmgrZPpu2ZboSddf/JB8UtLy
	 BWDGSFF/hIxEFdr08XfAyoonytAGJJof9UxmTn6c8k/5js+xYiYxZ4PzGt4Fug8odH
	 lz+lHJdt2S/+vaZwFeOU78wPKtj7vJofCl4mExneiSt3lgHoOAylfvo/A5u70+j8qr
	 z79j1f1bK5Ds/WckU9aBOLaivwbrpMkRsLgUfVmoX2XDaOUFCvflfb9BIsnv5PMLmY
	 hP9xqZ3VYWbRcHdsZtZEPKnl0rhpClq2COgeLG00DO6RBrsb6Q+S35nAviAy4OL/mC
	 u1H7vgoUWVtTw==
Date: Sun, 30 Nov 2025 17:45:02 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org
Subject: [ANN] net-next is CLOSED
Message-ID: <20251130174502.3908e3ee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi!

Linus tagged final v6.18 so net-next is closing. We will look thru
what's one the list, as usual, but no new postings, please.

