Return-Path: <netdev+bounces-104105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDDA490B397
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77C7D1F207C1
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCC715666A;
	Mon, 17 Jun 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s2QYjKBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8DB713E04C
	for <netdev@vger.kernel.org>; Mon, 17 Jun 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718634634; cv=none; b=YnIj+7n35SRdlj+KB0f3Y99emW7eig112J7yGxWzTFD46UsHUa+NnwoRd9iwcl1uyoKija+0717VSKuNtbqPxYcEQS5A7ZFZHrggQw5lLCTDUQLrt2KI2fDTFAeajSxcqJ8K5ZfajbzP0bijBtIsh2aZ2XiD5o0VpzGWJGfzmH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718634634; c=relaxed/simple;
	bh=4/jqlgF+Blg5VTNBDXqw1kucG3Wmkj1QeiNw8WSEGyE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=E5+bFqtByK4QBiDEHs35TW8TsuJ0g7TwLhxgLH6ut2/rRwCR4Zss5bD5X+/Ymp5h8ti8lOCZuTtELr5w7fEXBb3iUURcitmIRru4sJ8DIVJ5UZtHtlVv9vLjUwi+kOYQljwAtZ5h8GjDs1Ig5+E9NrY3j/+ooJ5GQKKLsiQLWjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s2QYjKBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40682C2BD10;
	Mon, 17 Jun 2024 14:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718634634;
	bh=4/jqlgF+Blg5VTNBDXqw1kucG3Wmkj1QeiNw8WSEGyE=;
	h=Date:From:To:Subject:From;
	b=s2QYjKBlepiTr3cH4h6qStU1jTl+yo4FdiSJN9Y4W0PKK2ZQc2g1vqc/K7i/AeHHR
	 wBbiA6fYG+9w2b1d0jLx5jQQOVIE7Z51sOgRk0Z0Qzb3TX4pC83LTDgspfCrB+NNsc
	 Fhxk3DBFNH+LlaWOS56gDZd+tHyEuz4JgKnNWXd+E+LZKYVp7X78wIbwqL3Ltf/R9Y
	 FQyY7HoQILiv5I+45NKUXDZdCp1L8EZMrz57d2C/ODF1jad5RLf9pvbs5QUiq1YfzX
	 k+LshK0m6tqHPw6SCAuqmvciUl58znI1YE8bUnY3RfOSrIKp7R5aTFKu7u6UdG12BP
	 767/L+jaGZ6iA==
Date: Mon, 17 Jun 2024 07:30:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: [TEST] AF_UNIX selftests integration
Message-ID: <20240617073033.0cbb829d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Kuniyuki!

We added running af_unix selftests to the net runner (using
the same kernel). diag_uid seems to be missing Kconfig options.
test_unix_oob appears to time out. Could you take a look?
For the Kconfig you can either create a local Kconfig or add to 
the existing net one.

