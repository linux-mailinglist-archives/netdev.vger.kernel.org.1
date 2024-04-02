Return-Path: <netdev+bounces-84066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F98D89568C
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 16:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38631282FB4
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 14:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E924486120;
	Tue,  2 Apr 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1kyeqs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C234280BEE
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 14:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712067949; cv=none; b=hcxVdFljYaNATLwY4Vd0H1VE82BHguDlrDm7B1qIEQN2RnPptAbeWIY8WkxELn06nGLvlJeK/U2LQ4ETzCG2F4TYwbXnl3j13vUJO9u+4rwI2o//dTsDFmElUfZjACgEkRFBX7oONu0JpXnECIQQppsa0uCRTJCMp3QlwykhlsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712067949; c=relaxed/simple;
	bh=cjKN5hbtCPmpzdSHcCawK2S+8/qL/Ksj9dPaudgrNeQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g1hwDxIcgFhdPzg2eBU1lN0xzYf9F9LftCSDaNll7XZXctKMAq3BGVzSl++Rn1cEfiqqxKI6Tsi+V7mL8qMYbOwiJQrorDv7XeUX3oDcsLjYfLxdsWvrYTeqt/t+V9DoGvHxwPhfP5+fbZxxBRq7gbzqMi7fKoqD74i/MCnq414=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e1kyeqs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D338FC433C7;
	Tue,  2 Apr 2024 14:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712067949;
	bh=cjKN5hbtCPmpzdSHcCawK2S+8/qL/Ksj9dPaudgrNeQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=e1kyeqs+mVApLka41jrcEPhGi2XtTDLVZijg91eIslOiToJyHw97oDPnlNvoYnJEs
	 +nSlXeIdxGzF4u0nqszEIG5gT4HJHGU2CGWmhk4LYO/xKYy3KjuubPYH2k2niJiPUv
	 UOScB+KvgpJ8TaCOFZ71eGFUCfoNUunWhQUW3JFi5opa8PO4Nmdm/nHr/x3aubDIKe
	 d7+OHjGPp10F2XTIl3CPnOqW3TvbgR0bD1/4lBZQsq0DhqKvAvqRJswQUs25rYr8nR
	 f2BUC39/qIAQfM3hQZx/vi9N6K9ks4b9rMKrPFrodZMZP6bd1N1q7PlT3mjDmyNSaY
	 wga5TdOcOfSUw==
Date: Tue, 2 Apr 2024 07:25:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Andrew Lunn <andrew@lunn.ch>, <netdev@vger.kernel.org>,
 <idosch@nvidia.com>, <edumazet@google.com>,
 <marcin.szycik@linux.intel.com>, <anthony.l.nguyen@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <pabeni@redhat.com>,
 <przemyslaw.kitszel@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next 0/3] ethtool: Max power
 support
Message-ID: <20240402072547.0ac0f186@kernel.org>
In-Reply-To: <a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
References: <20240329092321.16843-1-wojciech.drewek@intel.com>
	<38d874e3-f25b-4af2-8c1c-946ab74c1925@lunn.ch>
	<a3fd2b83-93af-4a59-a651-1ffe0dbddbe4@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Apr 2024 13:38:59 +0200 Wojciech Drewek wrote:
> > Also, this is about the board, the SFP cage, not the actual SFP
> > module?  Maybe the word cage needs to be in these names?  
> 
> It's about cage. Thanks for bringing it to my attention because now I
> see it might be misleading. I'm extending {set|show}-module command
> but the changes are about max power in the cage. With that in mind
> I agree that adding 'cage' to the names makes sense.

Noob question, what happens if you plug a module with higher power
needs into the cage?

