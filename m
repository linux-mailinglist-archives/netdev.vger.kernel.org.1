Return-Path: <netdev+bounces-243162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C84EC9A299
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 07:00:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8351D3A6993
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 05:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80632FD7A5;
	Tue,  2 Dec 2025 05:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pstTeh6b";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="pstTeh6b"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241FF2FDC4F
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 05:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764655136; cv=none; b=bh/ZsNnZtMa8Ws8s20xvS/DrAUnvd+lgtotEsLHBloy2wWHNqJIutL7srqU7O91alT9t+PA+ZEsSUEGOaUQ3gopYWuVy1fDfwzBCweVxCdPd1MgOPLGMXkkZE4JRkcNnAu4Dpq92Ohhlqu5WAZJBOMN8bHdELjIMRWX1lRnat2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764655136; c=relaxed/simple;
	bh=MiDFdE7FiYUxFFBebv6AScVQLqeIP/veOb9oKrbkBtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PtlCAFhdtdrlwQ7xtYPc2NyWdYvyrL5VimmKkaNK5bty8kPYLR7gi9inUUyfKEFMxgahE7L4VG5kCEylLIddYIBlL8kuugzSv7u8P1XONIl/+qStGtf01b8UdEtEZoM9eRwBYxh56ALuXN9KLWJr3UuaGKYbIN1bXmaBJ+Qjzzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pstTeh6b; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=pstTeh6b; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764655133;
	bh=MiDFdE7FiYUxFFBebv6AScVQLqeIP/veOb9oKrbkBtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pstTeh6bQQiw6ZgaN1r37ZsD+x+4hXv5hEEsVrvoFVdA2WNlpOmGF0++GuWBDEW7t
	 VGtFngJfAHgfZrYjtunBlCWq7aUfN4APVNAA5Dds2vU4nhh1U8S1WatY4bPadKYqk1
	 dgpXNRa2pdhaatEg445UcBn949V2ODt3qC2MS0FZnh8zZ0BfvOBa6zOE8arPTICJ07
	 LrT58K5u87UJGYIWz4JXn8Ibs99+gfL6zZ1M5Vq8uEYZhDADAQ9gaMr+BAodOqoSNu
	 4BAB0FsCyVM+jBc7k2y35Gg2LTlyrwB7D5jYUuT4xi6X3gyFP7e4ahUMdARPam8u9E
	 2G2mTqtmYrqxA==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9769F3EC72; Tue,  2 Dec 2025 05:58:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1764655133;
	bh=MiDFdE7FiYUxFFBebv6AScVQLqeIP/veOb9oKrbkBtA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=pstTeh6bQQiw6ZgaN1r37ZsD+x+4hXv5hEEsVrvoFVdA2WNlpOmGF0++GuWBDEW7t
	 VGtFngJfAHgfZrYjtunBlCWq7aUfN4APVNAA5Dds2vU4nhh1U8S1WatY4bPadKYqk1
	 dgpXNRa2pdhaatEg445UcBn949V2ODt3qC2MS0FZnh8zZ0BfvOBa6zOE8arPTICJ07
	 LrT58K5u87UJGYIWz4JXn8Ibs99+gfL6zZ1M5Vq8uEYZhDADAQ9gaMr+BAodOqoSNu
	 4BAB0FsCyVM+jBc7k2y35Gg2LTlyrwB7D5jYUuT4xi6X3gyFP7e4ahUMdARPam8u9E
	 2G2mTqtmYrqxA==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id CD33D3EC67;
	Tue,  2 Dec 2025 05:58:52 +0000 (UTC)
Message-ID: <b437f864-6eb5-4aab-951d-4e27c9978712@birger-koblitz.de>
Date: Tue, 2 Dec 2025 06:58:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 03/11] ixgbe: Add 10G-BX support
To: Tony Nguyen <anthony.l.nguyen@intel.com>, Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 andrew+netdev@lunn.ch, netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Rinitha S <sx.rinitha@intel.com>
References: <20251125223632.1857532-1-anthony.l.nguyen@intel.com>
 <20251125223632.1857532-4-anthony.l.nguyen@intel.com>
 <20251126153245.66281590@kernel.org>
 <93508e7f-cf7e-40f6-bf28-fb9e70ea3184@birger-koblitz.de>
 <20251127080748.423605a3@kernel.org>
 <49020773-43bc-4c46-8f95-a5436ca78891@birger-koblitz.de>
 <fcca2ea0-b0d9-4332-91f1-153be2063788@intel.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <fcca2ea0-b0d9-4332-91f1-153be2063788@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/12/2025 11:40 pm, Tony Nguyen wrote:
> 
> Hi Birger,
> 
> If you could send/treat it as a new version of the previous patch, and 
> send it like before, I'll handle it from there.
> 
> Thanks,
> Tony
> 
Hi Tony,

sent. Thanks a lot for your help!

Cheers,
   Birger

