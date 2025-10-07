Return-Path: <netdev+bounces-228121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 477BFBC1D06
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 16:51:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B145D4F76AD
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 14:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788BD2E22A7;
	Tue,  7 Oct 2025 14:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtFiw6q0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEBA1758B;
	Tue,  7 Oct 2025 14:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759848681; cv=none; b=lnUfQQC4UDwfUPZT/eP8glVgEaX9Bem4Go+UeBGVgiYrXINvHZpQi8gyV+NPeVd0Mw/Ib5S+13iYTSVBnhV51ZYsTRB1gW+W2euEszwh6+c3JJi/BsC+8jtVckTodzqpUy4FBXBPA44jE55D5Q15ms2+kVlb5bfst9aaYA9FDhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759848681; c=relaxed/simple;
	bh=PELynektC2WK3JpWbUIEnhC7VSvmJh0v6GXIxgNO0cE=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oM5tXOkp9e8R7GTJ/YAtHMCSVe5AylqsFPS3hOchIvIgAtbAyuLD9Xkblrh3EVzEhpeS+GXP3taNoHQQp8tvP+nANvD9ud3/ELt7s14U3rQ+8QcnynGdC/Oy6Hu5ygtasiIxQ3l2e0WyevZioZAKQhw6Bsq76uDWu206dJJp5NM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtFiw6q0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCE6C4CEF1;
	Tue,  7 Oct 2025 14:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759848680;
	bh=PELynektC2WK3JpWbUIEnhC7VSvmJh0v6GXIxgNO0cE=;
	h=Date:From:To:Subject:In-Reply-To:References:From;
	b=PtFiw6q03fS8ac1L9nB11FUtJIclopbn3UMyJQG2Y44WwQZpKZ+uytZ4oVkSdhGsR
	 GmkE3YXKPUKx2qJy276+phd+Wd6Juorcot35q6yj55zeFWMI7Fkyi7aHDyXJ3SmutZ
	 w5yY1CuqlgHJYX9wMtfUwPudKY/tZCh5vOBqb7dkxpaJGF0o9j7p35ui6waRHQyye2
	 DFcKNhgPCglkcjsNwdCoPUlFQOyzm37FLE0Iu4ZPfO2SiRA1iwuf2VAvqU1TGvWEaa
	 QIXoH5e3QCSsgW3acAbginpQ9oplMEiYEmAqsfHl2Pzy32j3Iz1pWr9sHhxPUY35kM
	 l4NW2D1o5fMMQ==
Date: Tue, 7 Oct 2025 07:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: netdev@vger.kernel.org, netdev-driver-reviewers@vger.kernel.org
Subject: Re: [ANN] netdev call - Oct 7th
Message-ID: <20251007075119.731631ef@kernel.org>
In-Reply-To: <20251006122307.2bc93c9c@kernel.org>
References: <20251006122307.2bc93c9c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 6 Oct 2025 12:23:07 -0700 Jakub Kicinski wrote:
> Hi!
> 
> The bi-weekly call is scheduled for tomorrow at 8:30 am (PT) / 
> 5:30 pm (~EU), at https://bbb.lwn.net/rooms/ldm-chf-zxx-we7/join
> 
> No agenda at this stage. Please reply with suggestions, if no topics
> are proposed before the meeting we'll cancel.

Alrighty, canceled.

