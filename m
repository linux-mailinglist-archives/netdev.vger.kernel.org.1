Return-Path: <netdev+bounces-21146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 882B7762924
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:13:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42C59281AAD
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97381878;
	Wed, 26 Jul 2023 03:13:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26781FA1
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:13:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16687C433C8;
	Wed, 26 Jul 2023 03:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341218;
	bh=ArzOhK0DABJZELm/FIM672/PGVKzUGvrh6DMoK0fKkI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jas75pM2RksPKh4kb4E/OQAfs6K20JP+pggkcoE7c59LPuUkpXm6dQTtX9lBku/dW
	 FY+fLBLG6VeY6btNr1bzAJkG8PUcvaEghwxIg/jgW+vwAsxLOnnod0g3YUqkxo9we6
	 k22mEo9sHuzH1rRP7tdZZEb6Ouc0d/5VsZ33LoJhLsdkqovq8elQKLyw2uIn24hxQv
	 0zTG8ztlEDU+fNiT3npYsHKFmEHKryALtsqpxeFMs7lQhxbA8qaIW2vf1a7meEyRgt
	 pMrHobryfvNmCB2bqw9s2e7o/QbE1ZilIW2pPWVsdLX0bLH65Gx3ab1YoVSHXfo5O+
	 tLt0wkOyco+jg==
Date: Tue, 25 Jul 2023 20:13:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Cc: donald.hunter@gmail.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, simon.horman@corigine.com
Subject: Re: [PATCH net-next v4 0/2] tools: ynl-gen: fix parse multi-attr
 enum attribute
Message-ID: <20230725201337.54e12d33@kernel.org>
In-Reply-To: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
References: <20230725101642.267248-1-arkadiusz.kubalewski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Jul 2023 12:16:40 +0200 Arkadiusz Kubalewski wrote:
> Fix the issues with parsing enums in ynl.py script.

In case DaveM wants to take these in the morning already:

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

