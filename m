Return-Path: <netdev+bounces-114780-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6E59440BE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47C08282636
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9F51A6198;
	Thu,  1 Aug 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nhIcJHJk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D011A6190
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722476413; cv=none; b=Tw7XeuqdjXx0A4Xw0ye/d3kVgrkw4Nr3U+wxSXCtknnYUTZv7zfaWmuazGZUwLaCCNsAALkLQQKuUrK7YIzU7KLhJhXj5s33Gp2uHbx4TdU5MRTqfLWaWzTh2O83D6sLbYgosiNJEAsyeX4s1IHi7eVy855ADJCSoKlj8aOaQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722476413; c=relaxed/simple;
	bh=ENqo943MoZ0n/qyMNWsT9+U8Q7Yh5tKxqV/mLCQyJJg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwxBbAzoB3ZB2Jedbg/i/aqKUswdpSPIbjG8+xHVN4R0IL4sQ7rL6itvolPmfaYa5E7v/It6aEn8kyKWAOJSFfDk0skch876UKTq6Xdsr2SAKfIQKNAQI0qxm9b6lFWj7AdxU3IoGTN5V3EzyIddiriKsB73VOkGNH1ESnEeqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nhIcJHJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E06C4AF0C;
	Thu,  1 Aug 2024 01:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722476413;
	bh=ENqo943MoZ0n/qyMNWsT9+U8Q7Yh5tKxqV/mLCQyJJg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nhIcJHJk2jdFoO2vuKqDhnlpkws8pW6VF10p6UGoRqcguGPXkLBQUP+CsfRKHhp8w
	 hf9s0toiGUibtjI5sI95ChnvcnT+JezfJsAtf931lEynZ/J9yNinDoLC0qjVo1QoP2
	 fleudfHRFT0QJW1385GtxPTbrhhMkgL2GlGbugK2SQx6b0w3t6c/+uTJdzO2f7jiG1
	 d6i3C0lb2LU3rNn4WnodV93HeV/Uzr+3OlQqu6Wy6FoC9ri3QeMy+Ldjxvn/rdRRCL
	 LvfUezzdu/2YHBRXvbtVvohOJ5rGBZF05tJUKW4UCwi0wjD7XYRObc5zCzmIoNQfV5
	 FmIm1+f62bdMw==
Date: Wed, 31 Jul 2024 18:40:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel
 <idosch@nvidia.com>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 10/10] mlxsw: core_thermal: Fix
 -Wformat-truncation warning
Message-ID: <20240731184011.3f530efa@kernel.org>
In-Reply-To: <583a70c6dbe75e6bf0c2c58abbb3470a860d2dc3.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
	<583a70c6dbe75e6bf0c2c58abbb3470a860d2dc3.1722345311.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Jul 2024 15:58:21 +0200 Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The name of a thermal zone device cannot be longer than 19 characters
> ('THERMAL_NAME_LENGTH - 1'). The format string 'mlxsw-lc%d-module%d' can
> exceed this limitation if the maximum number of line cards cannot be
> represented using a single digit and the maximum number of transceiver
> modules cannot be represented using two digits.

The ordering could have been better since this comes from patch 6 
in the same series :(

