Return-Path: <netdev+bounces-78564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E49875BBD
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 02:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3BCC81C20E78
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 01:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88625210EC;
	Fri,  8 Mar 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY31fV2d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645C524208
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 00:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709859559; cv=none; b=kF9sevJ9ok8xH5w3c/w0tPMa+Zsv4hp3QhT3GdpwiVdJP01ekjxKorYeV7k984M81y5nbUQ4D4GXOJlG5ZU3OFQ2SH+h8owROoxLOf+T5HaAT+zFft4Df7bXydLQEI+2Dpq52QxeQA0Y2OWiN7uuCXAYQqqEsah/UHcQKLHux1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709859559; c=relaxed/simple;
	bh=Klk11SlhhvsmE6syTmr18qqVAISLa1l7ujAX0jGrfPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Al8UzIMAYA6CK9gtLu+eFh8ME7epRvlU3AmbbglIrcmA6F750SnyqWzUqGfC4It2OwgLq9MIuiRLJ753t/hD35O8acjgETiR7FZpIvyMAooOU2UxnFI9S1lj3mEZTPB7l6sYPy6W8uc7N023sgYDQ4zYdYsDhdPnKp43Y3suQLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY31fV2d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57EBC433C7;
	Fri,  8 Mar 2024 00:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709859559;
	bh=Klk11SlhhvsmE6syTmr18qqVAISLa1l7ujAX0jGrfPc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kY31fV2dh8AIYlbfaZV73a5QUjW1A26oVgP2S/BOQ3A1OZzjnDgkUkvp3RdoTFAQd
	 bYAUSrOfim36KZkGNTecZlZOdzarHrOFCSuvsXcSliMEuztfaxRWzd0PRWUnGX7hXU
	 6wMjuVFPgtQXni31gscOrxNcKHMGfcVheAfQBOpgs9TAkcZhpUK2sLc1OiV06UxvmS
	 85EuxM4fP+795h9KsIZWI0H1XobEHoQP+s/S2/B+bAxwQLLA/P3c/vXGeLRN+x+Tnn
	 ckdaNaeH9DQtpGPUKVgcBOsOv5zrqVira14P+TfyVWXdxL0xscqfw0b2hf1WyqOitj
	 2UOgPeLiXVuWA==
Date: Thu, 7 Mar 2024 16:59:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Louis Peens <louis.peens@corigine.com>
Cc: Jiri Pirko <jiri@resnulli.us>, David Miller <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Fei Qin <fei.qin@corigine.com>,
 netdev@vger.kernel.org, oss-drivers@corigine.com
Subject: Re: [PATCH net-next v2 1/4] devlink: add two info version tags
Message-ID: <20240307165917.70acd8f1@kernel.org>
In-Reply-To: <Zeml4L6EUmlCHU37@nanopsycho>
References: <20240228075140.12085-1-louis.peens@corigine.com>
	<20240228075140.12085-2-louis.peens@corigine.com>
	<Zd8js1wsTCxSLYxy@nanopsycho>
	<20240228203235.22b5f122@kernel.org>
	<Zel4F74EqG2YMf+w@LouisNoVo>
	<Zel9k5uliEyi9ZTp@nanopsycho>
	<Zemfzkv4/FevHHfS@LouisNoVo>
	<Zeml4L6EUmlCHU37@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 12:32:48 +0100 Jiri Pirko wrote:
> >I don't know if it is specific to us, that's the thing, maybe it is,
> >maybe it isn't. What I do know in our case is that "part_number" and
> >"board.id" is not the same thing, so we would prefer to have both visible.
> >I cannot comment if that is the case for others, if the concensus is
> >that others will find this helpful we don't mind adding it to devlink,
> >as we've done from v1 to v2 - exact naming disussion aside.
> >
> >Updated proposal after this comment, V3 would then be:
> >1) Keep "board.model" (the codename) local like it currently exist
> >in-tree.
> >2) Do still add "part_number" to devlink, but call it "board.part_number".
> >Looking at the existing options it probably does fit the closest with
> >board, it's not "fw", and I don't think it's "asic" either.
> >
> >Does this sound like the right track?  
> 
> Okay.

+1 

