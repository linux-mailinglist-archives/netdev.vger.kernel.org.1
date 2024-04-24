Return-Path: <netdev+bounces-91055-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19D408B127B
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BDEF1C22C15
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 18:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0B4168C7;
	Wed, 24 Apr 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bt5ER2om"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8BD918B1A
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 18:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713983917; cv=none; b=TICSJfYnT4K5D+YWqNmODrzJ7OSptM1m56Bih+djXldLiDM6nNB93tewmbm1c/k80aIpaHIB8x3J6s58NiDMI3cmz8JZjRpy/2qtokE/D1fRs+a5BlbtJqps+avWmnozb5hKKLQdpB+ABUdxdYg1T711fhBuh5ZFcp2kDZzMYoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713983917; c=relaxed/simple;
	bh=X1iJKPmkM/XQXaboSvgAZe09r+e8QT0bBM4PJP0lRis=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i45vv0PWO1/pKeGWeb70+NdBD6zU4FxE0qkwPTmBRVpGuPclSKEhe43uFqKUihVaLW2GdXFaVIs37jdaLX35gijnoCnWb0I7Yx7PzbFo3gvb+6IDrNvrutFI8lc8IRpk+P4asnWzB1u9v5cC7X0DM/uNPF9bqe/nQmyYsNHE21M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bt5ER2om; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A249C113CD;
	Wed, 24 Apr 2024 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713983917;
	bh=X1iJKPmkM/XQXaboSvgAZe09r+e8QT0bBM4PJP0lRis=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bt5ER2omKs7l0EjMN2DtMQwFcNUKUvY4Cyzg8IOyCe9xjmOF0WAZduTWOiwmLMBu0
	 7cbgj9FI6T7y9XhfK0uKBMSCY8yEF8f1cRgrS6DiuxrEkrI0UFgehTqoOIxJqO5YdW
	 zdUy7ZKiapUL/hY7q6fVCLlBJ1vEdV11VbqqjPsXGcWN3gjTGRuuMz0AtEiJJgda/W
	 zMSTOfCJ0WKkiaNBLIwVGV45oPAmKqHc5nZlGqBKPnCd8zCAdJh1bm7jhkGG5SlEUp
	 EXqHjX+Of9jQ5hY8xHgADmU0SHvp0hR2ZadXJEig5JvqmxwR/wsrEA1H1b1nDsJdkN
	 zI3ax53gvo8Jw==
Date: Wed, 24 Apr 2024 11:38:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com, Donald
 Hunter <donald.hunter@gmail.com>
Subject: Re: [PATCH net] MAINTAINERS: add an explicit entry for YNL
Message-ID: <20240424113836.4263927d@kernel.org>
In-Reply-To: <20240424183759.4103862-1-kuba@kernel.org>
References: <20240424183759.4103862-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Apr 2024 11:37:59 -0700 Jakub Kicinski wrote:
> Donald has been contributing to YNL a lot. Let's create a dedicated
> MAINTAINERS entry and add make his involvement official :)
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Adding the CC..

