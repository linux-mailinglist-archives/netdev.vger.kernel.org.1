Return-Path: <netdev+bounces-262723-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPCXGl21pWkBFQAAu9opvQ
	(envelope-from <netdev+bounces-262723-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:05:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 719201DC5A2
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 17:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F14F030689FE
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 15:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028B84219E7;
	Mon,  2 Mar 2026 15:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="zHZDllC4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929A1423158
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 15:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772466875; cv=none; b=HFBGa8L7YXwrJlhQfjVq+e/V4zHEIc9FG1617y4cHa38ARsxrrd0qcp+CA1o51Kdhk0G16By5Gqb2QZ4SMwXlep8As1FfI+JIHci6IWLzoq3OKA5wm/u6y37N9RUadOsow1BkBgIBLtDa6D+hHsD2xqyEtYnZ2qSScEsN8zR2Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772466875; c=relaxed/simple;
	bh=dDpcbfDi0yi7fEFTxd12xIV5BQ3X3OV+mFeaeykwVCM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+hhvU7FiWLGRjrEIvgLcmADf54h4cucdCjwWCVzs5lv0+PwTgnCul/qiqWqEoqawbnj7bwDsOzl6s5VUZvJq5GYDUpTJNeO1ZfbJTusPiaI5JHanyMjBgBq+gKEw4BbIHfLQyYraeI3BdUf73DnpWDb+OUgohqgXYrdvEf0+P0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=zHZDllC4; arc=none smtp.client-ip=74.125.82.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-2be06a2be90so2286167eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Mar 2026 07:54:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1772466870; x=1773071670; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vYKX84PLbw1ik011AtUFY/JoiQVlKtt+8d30XwsrbyA=;
        b=zHZDllC4F8vhmIye6X0hKfi9I2znFzlhAdHfhUzK/9PJ1wSMBFVNUcRV2K/Q0E6FbO
         dGSLu/ViHr6mZbr+JxW8NvqoUglssyBfP4LnrZ1BmfutjquEOmST1/7G3ZETOXSA3Z0y
         A4Jidrl15Ex/tcF6Vn2k/gjER8+zmvFhkeNhvoIwCZTIa5GZc16Qbo7QHNFDudOqu7CE
         0ZfH7KVe56T242mitHDwKgrCsLFynQRTJ0MY5TI7EIBEEYNUhAsh6l/UPSPfsESPvRzM
         kdXFOVjBgWDRvAm1jA4hweX9x96FI8oH3LchAe6U58mnQkFtCsbUjkHTdL3Iee3u5Blt
         5C9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772466870; x=1773071670;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vYKX84PLbw1ik011AtUFY/JoiQVlKtt+8d30XwsrbyA=;
        b=Frba0IHJRukDnXLcgGRuPZoMvtldIxJSxnWY26LZ+03mbT03iXJg0SHHMbb36FKeBq
         7gCLDejsJ0NJrYLq5fLnsZzZBflHSAdJcBLL3xUkYqA39oqB74uUuPvxF9ItV9xAAqfM
         CqSu7jkKhdfgm+vSMOoInXoOtq2BYjVu4dtAfn4pXy1FrcrSkxPsrIPzSqrJLT0UNlsl
         aUJwIXwDo4WwxwjFx8uj69vJccHjzVQ2B+gHjWlr11S4SINfMCtsz+IPxs9p8XicXZLu
         0TH/+jFQy5ExRmMPECJe0L+XUvmNMmx14Dy6gfUWKTa/mI6AJnuzHew5L3+XF3QXatCj
         MubA==
X-Gm-Message-State: AOJu0YwhJUEiaWRBp1Ha7y52ZPtBM6rGcYyIU07dxCtNIbXdOrepti/N
	DBeVFJauE7y99Uwd4pedlt1AckK9b+V2NaCf0Y+7vJ4cT2Lmhr6mioZ6Ot/TkPKc/0Q=
X-Gm-Gg: ATEYQzxSSe322EaTu2fcw1i6/qqXmW4FWjxN6w7wDHLT0y/LqT2zlgJkFtVR85q3tx5
	5QN72mqZ6Kr1qwyr402slK2W80mz/lK+UhOXrdE2g05vI1uW0AZRHrWp9NJK36ul9Hvb9moep+o
	60n2Cmqc0Vu/uvtAjk1StV6136y3Q5pc6FzxgRJo0AFHNY20TCTuo6e0+2dA4HOI/fJ0hRUSn0r
	nG5iMZoLqoaIy60aPo8/0+OpHWJrRHeF3dE9ssm7lAFfo/oUN3vK5O8namLux5fewIQv0awxe8v
	yw6yfYKJuCayzGpN1xibhAWNMi5vx0GMAOza+Lfk9PstxmXOrsalqeAovyYM6Fnb8PZbT/Rf6Wz
	PVwgqBZV6B/LMbDrK8SRidNdg4vDUEWcHew5BK/6FXNupxGrLsoqREPK6SnA4743+Fk3jEHq9/C
	/kz5Z/OK/iuPr51IXP9TCVUGK+cq3ani5R/G3K2oNW+xGqJByonNjEoNn7l8xtO0VQYGyUgGGzG
	2H0Z4jqvlHpyvzVB9Mfh9eo7BwERSZH
X-Received: by 2002:a05:7301:fa0b:b0:2be:617:2ddf with SMTP id 5a478bee46e88-2be06173268mr2046986eec.16.1772466870425;
        Mon, 02 Mar 2026 07:54:30 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1156:1:c8f:b917:4342:fa09? ([2620:10d:c090:500::badb])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bdd1a45a58sm10660215eec.0.2026.03.02.07.54.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Mar 2026 07:54:30 -0800 (PST)
Message-ID: <90cfcf06-e987-4817-acba-2037a436a744@davidwei.uk>
Date: Mon, 2 Mar 2026 07:54:28 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] selftests: drv-net: iou-zcrx: rework large
 chunks test to use common setup
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, jdamato@fastly.com,
 asml.silence@gmail.com, io-uring@vger.kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260227171305.2848240-1-kuba@kernel.org>
 <20260227171305.2848240-3-kuba@kernel.org>
Content-Language: en-US
From: David Wei <dw@davidwei.uk>
In-Reply-To: <20260227171305.2848240-3-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 719201DC5A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-262723-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[davidwei.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,fastly.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,fastly.com:email,iou-zcrx.py:url]
X-Rspamd-Action: no action

On 2026-02-27 09:13, Jakub Kicinski wrote:
> Commit a32bb32d0193 ("selftests: iou-zcrx: test large chunk sizes")
> and commit de7c600e2d5b ("selftests/net: parametrise iou-zcrx.py with
> ksft_variants") landed at similar time. The large chunks test was
> actually not included in the list of tests, so it never run.
> We haven't noticed that it uses the old-style helpers
> (_get_combined_channels, _get_current_settings, _set_flow_rule)
> that were removed by the other commit.
> 
> Rework test_zcrx_large_chunks to reuse the single() setup function
> and add it to the ksft_run cases list so it actually gets executed.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shuah@kernel.org
> CC: dw@davidwei.uk
> CC: jdamato@fastly.com
> CC: linux-kselftest@vger.kernel.org
> ---
>   .../selftests/drivers/net/hw/iou-zcrx.py      | 31 ++++---------------
>   1 file changed, 6 insertions(+), 25 deletions(-)
> 
> diff --git a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> index c27c2064701d..1649c23e05e2 100755
> --- a/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> +++ b/tools/testing/selftests/drivers/net/hw/iou-zcrx.py
> @@ -135,36 +135,16 @@ SKIP_CODE = 42
>   
>       cfg.require_ipver('6')
>   
> -    combined_chans = _get_combined_channels(cfg)
> -    if combined_chans < 2:
> -        raise KsftSkipEx('at least 2 combined channels required')
> -    (rx_ring, hds_thresh) = _get_current_settings(cfg)
> -    port = rand_port()
> -
> -    ethtool(f"-G {cfg.ifname} tcp-data-split on")
> -    defer(ethtool, f"-G {cfg.ifname} tcp-data-split auto")
> -
> -    ethtool(f"-G {cfg.ifname} hds-thresh 0")
> -    defer(ethtool, f"-G {cfg.ifname} hds-thresh {hds_thresh}")
> -
> -    ethtool(f"-G {cfg.ifname} rx 64")
> -    defer(ethtool, f"-G {cfg.ifname} rx {rx_ring}")
> -
> -    ethtool(f"-X {cfg.ifname} equal {combined_chans - 1}")
> -    defer(ethtool, f"-X {cfg.ifname} default")
> -
> -    flow_rule_id = _set_flow_rule(cfg, port, combined_chans - 1)
> -    defer(ethtool, f"-N {cfg.ifname} delete {flow_rule_id}")
> -
> -    rx_cmd = f"{cfg.bin_local} -s -p {port} -i {cfg.ifname} -q {combined_chans - 1} -x 2"
> -    tx_cmd = f"{cfg.bin_remote} -c -h {cfg.addr_v['6']} -p {port} -l 12840"
> +    single(cfg)

Let's use ksft_variants() with both single() and rss()?

