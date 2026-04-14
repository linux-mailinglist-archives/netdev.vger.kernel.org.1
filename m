Return-Path: <netdev+bounces-278324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMdEDBDy3WmMlQkAu9opvQ
	(envelope-from <netdev+bounces-278324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:51:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 995603F6C0D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04E6B3023D9D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A593A3845CB;
	Tue, 14 Apr 2026 07:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="avaxYldX"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030902D8391
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153100; cv=none; b=mAV0d9vdhs+qIbD/zX7QLTzmv7UKxnixq3xYQbbbbrEEZ3PYut6cn47gwjJ6TQtOCRjrLk2WB+874MUHJdg8x4EHi8PzoUuRZvIlxIyyqiPlfo3iz44bnbKnTgeR0zAOGx4rSXihv/44E5YfJP1lB+CNLqbD0C1s7XayL4ep9MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153100; c=relaxed/simple;
	bh=bn337k3ZS/CvW7cQfGlAb9f0r4BdutvY8tQckTZKCwI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y2PKf+4pDsI2uHvQFiHWZxjZmQGyZSArvR1rJllkfBFHzum3KT/3uwSfjeB2x5wshiTnOgPv0aYy5tTP7qCthkBGq966+lfm3DOJNJeHdnn815mi8qEdfcgLJLNYFzed/CLuYz4x2FiDDEljna/S/s8CYdueLDKaW6Hglp/CfJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=avaxYldX; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=70hKtPzSqIxA234zEC01cn/I7CQG8vGPXB3NJzec2SQ=; b=avaxYldXvWLDuSI30e5NJgkCA0
	tGyuIEtmMJdZM4ZWwfJ5HBy+MfT9qeFhGI4yiHn7o1hzYzRR1MB6GsYSYlNwG4BWNPdVkDNkulIb7
	RYf8SMJcV2sJ9/s7SBl8eYIbYenRBasgaPSYYctMoOZugWgocLc5q3tqnfs634dd8mx8ElVpV1kIv
	o0G1snrmS+eIkc1BPl9m9Eh8XgcGHFKvYjcPFTnxHfNgNZLZMKCx30TwuDUlChjloSd/37ocpEVwr
	IOnYxyNV7+pzczaQq49OgvT1snFzyG1INWthwyAyY0dX+tUoTFZE9rH/Vq+NaPifdUSBVXFcKvwU/
	Tu2wWO4w==;
Received: from sslproxy01.your-server.de ([78.46.139.224])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCYYX-000CMM-1J;
	Tue, 14 Apr 2026 09:51:33 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy01.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCYYW-0003jd-32;
	Tue, 14 Apr 2026 09:51:32 +0200
Message-ID: <80a19313-482f-4adb-995b-b6db8a819727@iogearbox.net>
Date: Tue, 14 Apr 2026 09:51:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 0/3] Follow-ups to nk_qlease net selftests
From: Daniel Borkmann <daniel@iogearbox.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, dw@davidwei.uk, pabeni@redhat.com,
 razor@blackwall.org
References: <20260413220809.604592-1-daniel@iogearbox.net>
 <20260413191237.43eee559@kernel.org>
 <255394e2-fe42-4e3a-834b-42a0c7153f28@iogearbox.net>
Content-Language: en-US
Autocrypt: addr=daniel@iogearbox.net; keydata=
 xsFNBGNAkI0BEADiPFmKwpD3+vG5nsOznvJgrxUPJhFE46hARXWYbCxLxpbf2nehmtgnYpAN
 2HY+OJmdspBntWzGX8lnXF6eFUYLOoQpugoJHbehn9c0Dcictj8tc28MGMzxh4aK02H99KA8
 VaRBIDhmR7NJxLWAg9PgneTFzl2lRnycv8vSzj35L+W6XT7wDKoV4KtMr3Szu3g68OBbp1TV
 HbJH8qe2rl2QKOkysTFRXgpu/haWGs1BPpzKH/ua59+lVQt3ZupePpmzBEkevJK3iwR95TYF
 06Ltpw9ArW/g3KF0kFUQkGXYXe/icyzHrH1Yxqar/hsJhYImqoGRSKs1VLA5WkRI6KebfpJ+
 RK7Jxrt02AxZkivjAdIifFvarPPu0ydxxDAmgCq5mYJ5I/+BY0DdCAaZezKQvKw+RUEvXmbL
 94IfAwTFA1RAAuZw3Rz5SNVz7p4FzD54G4pWr3mUv7l6dV7W5DnnuohG1x6qCp+/3O619R26
 1a7Zh2HlrcNZfUmUUcpaRPP7sPkBBLhJfqjUzc2oHRNpK/1mQ/+mD9CjVFNz9OAGD0xFzNUo
 yOFu/N8EQfYD9lwntxM0dl+QPjYsH81H6zw6ofq+jVKcEMI/JAgFMU0EnxrtQKH7WXxhO4hx
 3DFM7Ui90hbExlFrXELyl/ahlll8gfrXY2cevtQsoJDvQLbv7QARAQABzSZEYW5pZWwgQm9y
 a21hbm4gPGRhbmllbEBpb2dlYXJib3gubmV0PsLBkQQTAQoAOxYhBCrUdtCTcZyapV2h+93z
 cY/jfzlXBQJjQJCNAhsDBQkHhM4ACAsJCAcNDAsKBRUKCQgLAh4BAheAAAoJEN3zcY/jfzlX
 dkUQAIFayRgjML1jnwKs7kvfbRxf11VI57EAG8a0IvxDlNKDcz74mH66HMyhMhPqCPBqphB5
 ZUjN4N5I7iMYB/oWUeohbuudH4+v6ebzzmgx/EO+jWksP3gBPmBeeaPv7xOvN/pPDSe/0Ywp
 dHpl3Np2dS6uVOMnyIsvmUGyclqWpJgPoVaXrVGgyuer5RpE/a3HJWlCBvFUnk19pwDMMZ8t
 0fk9O47HmGh9Ts3O8pGibfdREcPYeGGqRKRbaXvcRO1g5n5x8cmTm0sQYr2xhB01RJqWrgcj
 ve1TxcBG/eVMmBJefgCCkSs1suriihfjjLmJDCp9XI/FpXGiVoDS54TTQiKQinqtzP0jv+TH
 1Ku+6x7EjLoLH24ISGyHRmtXJrR/1Ou22t0qhCbtcT1gKmDbTj5TcqbnNMGWhRRTxgOCYvG0
 0P2U6+wNj3HFZ7DePRNQ08bM38t8MUpQw4Z2SkM+jdqrPC4f/5S8JzodCu4x80YHfcYSt+Jj
 ipu1Ve5/ftGlrSECvy80ZTKinwxj6lC3tei1bkI8RgWZClRnr06pirlvimJ4R0IghnvifGQb
 M1HwVbht8oyUEkOtUR0i0DMjk3M2NoZ0A3tTWAlAH8Y3y2H8yzRrKOsIuiyKye9pWZQbCDu4
 ZDKELR2+8LUh+ja1RVLMvtFxfh07w9Ha46LmRhpCzsFNBGNAkI0BEADJh65bNBGNPLM7cFVS
 nYG8tqT+hIxtR4Z8HQEGseAbqNDjCpKA8wsxQIp0dpaLyvrx4TAb/vWIlLCxNu8Wv4W1JOST
 wI+PIUCbO/UFxRy3hTNlb3zzmeKpd0detH49bP/Ag6F7iHTwQQRwEOECKKaOH52tiJeNvvyJ
 pPKSKRhmUuFKMhyRVK57ryUDgowlG/SPgxK9/Jto1SHS1VfQYKhzMn4pWFu0ILEQ5x8a0RoX
 k9p9XkwmXRYcENhC1P3nW4q1xHHlCkiqvrjmWSbSVFYRHHkbeUbh6GYuCuhqLe6SEJtqJW2l
 EVhf5AOp7eguba23h82M8PC4cYFl5moLAaNcPHsdBaQZznZ6NndTtmUENPiQc2EHjHrrZI5l
 kRx9hvDcV3Xnk7ie0eAZDmDEbMLvI13AvjqoabONZxra5YcPqxV2Biv0OYp+OiqavBwmk48Z
 P63kTxLddd7qSWbAArBoOd0wxZGZ6mV8Ci/ob8tV4rLSR/UOUi+9QnkxnJor14OfYkJKxot5
 hWdJ3MYXjmcHjImBWplOyRiB81JbVf567MQlanforHd1r0ITzMHYONmRghrQvzlaMQrs0V0H
 5/sIufaiDh7rLeZSimeVyoFvwvQPx5sXhjViaHa+zHZExP9jhS/WWfFE881fNK9qqV8pi+li
 2uov8g5yD6hh+EPH6wARAQABwsF8BBgBCgAmFiEEKtR20JNxnJqlXaH73fNxj+N/OVcFAmNA
 kI0CGwwFCQeEzgAACgkQ3fNxj+N/OVfFMhAA2zXBUzMLWgTm6iHKAPfz3xEmjtwCF2Qv/TT3
 KqNUfU3/0VN2HjMABNZR+q3apm+jq76y0iWroTun8Lxo7g89/VDPLSCT0Nb7+VSuVR/nXfk8
 R+OoXQgXFRimYMqtP+LmyYM5V0VsuSsJTSnLbJTyCJVu8lvk3T9B0BywVmSFddumv3/pLZGn
 17EoKEWg4lraXjPXnV/zaaLdV5c3Olmnj8vh+14HnU5Cnw/dLS8/e8DHozkhcEftOf+puCIl
 Awo8txxtLq3H7KtA0c9kbSDpS+z/oT2S+WtRfucI+WN9XhvKmHkDV6+zNSH1FrZbP9FbLtoE
 T8qBdyk//d0GrGnOrPA3Yyka8epd/bXA0js9EuNknyNsHwaFrW4jpGAaIl62iYgb0jCtmoK/
 rCsv2dqS6Hi8w0s23IGjz51cdhdHzkFwuc8/WxI1ewacNNtfGnorXMh6N0g7E/r21pPeMDFs
 rUD9YI1Je/WifL/HbIubHCCdK8/N7rblgUrZJMG3W+7vAvZsOh/6VTZeP4wCe7Gs/cJhE2gI
 DmGcR+7rQvbFQC4zQxEjo8fNaTwjpzLM9NIp4vG9SDIqAm20MXzLBAeVkofixCsosUWUODxP
 owLbpg7pFRJGL9YyEHpS7MGPb3jSLzucMAFXgoI8rVqoq6si2sxr2l0VsNH5o3NgoAgJNIg=
In-Reply-To: <255394e2-fe42-4e3a-834b-42a0c7153f28@iogearbox.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27971/Tue Apr 14 08:24:44 2026)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,iogearbox.net:dkim,iogearbox.net:mid]
X-Rspamd-Queue-Id: 995603F6C0D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/14/26 9:33 AM, Daniel Borkmann wrote:
> On 4/14/26 4:12 AM, Jakub Kicinski wrote:
>> On Tue, 14 Apr 2026 00:08:03 +0200 Daniel Borkmann wrote:
>>> This is a set of follow-ups addressing [0]:
>>>
>>> - Split netdevsim tests from HW tests in nk_qlease and move the SW
>>>    tests under selftests/net/
>>> - Remove multiple ksft_run()s to fix the recently enforced hard-fail
>>> - Move all the setup inside the test cases for the ones under
>>>    selftests/net/ (I'll defer the HW ones to David)
>>> - Add more test coverage related to queue leasing behavior and corner
>>>    cases, so now we have 45 tests in nk_qlease.py with netdevsim
>>>    which does not need special HW
>>
>> LGTM, thanks!
>>
>> I'll let it run overnight in the CI to shake out any latent flakiness
>> (and the crash which I think is from Stan's series).
>>
>> Could you cook up one more follow up to enable VETH in the config?
>> We're getting:
>>
>> # # Exception| Traceback (most recent call last):
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/ksft.py", line 420, in ksft_run
>> # # Exception|     func(*args)
>> # # Exception|     ~~~~^^^^^^^
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/drivers/net/hw/./nk_qlease.py", line 393, in test_veth_queue_create
>> # # Exception|     ip("link add veth0 type veth peer name veth1")
>> # # Exception|     ~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 238, in ip
>> # # Exception|     return tool('ip', args, json=json, host=host)
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 225, in tool
>> # # Exception|     cmd_obj = cmd(cmd_str, ns=ns, host=host)
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 91, in __init__
>> # # Exception|     self.process(terminate=False, fail=fail, timeout=timeout)
>> # # Exception|     ~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>> # # Exception|   File "/srv/vmksft/testing/wt-24/tools/testing/selftests/net/lib/py/utils.py", line 117, in process
>> # # Exception|     raise CmdExitFailure("Command failed", self)
>> # # Exception| net.lib.py.utils.CmdExitFailure: Command failed
>> # # Exception| CMD: ip link add veth0 type veth peer name veth1
>> # # Exception|   EXIT: 2
>> # # Exception|   STDERR: Error: Unknown device type.
>> # # Exception|
>> # not ok 27 nk_qlease.test_veth_queue_create
>>
>> I guess you can post it without waiting for this to be merged, it won't
>> conflict.
> 
> Ack, will take a look! Thanks!

After this series here, there is no veth test left anymore under
tools/testing/selftests/drivers/net/hw/ and they moved over to the
tools/testing/selftests/net/nk_qlease.py which already has the needed
CONFIG_VETH=y (in tools/testing/selftests/net/config).

Stan's series was run where this one here is not in the tree yet, so
if we would add CONFIG_VETH=y into tools/testing/selftests/drivers/net/hw/config
it would be unnecessary - I presume we don't want to add in that case.

Thanks,
Daniel

