Return-Path: <netdev+bounces-213999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD98AB27AB9
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E251E7A4DA2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938181C8632;
	Fri, 15 Aug 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XsILf4Fg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZzYLnIyM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB84322083
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245843; cv=none; b=cFjtWhtaecOr91XBzDzJLwCy9HpYwusOqJF+uX4alLFt1826P1Zccu8YxdfLlUZTfijifM5eHG6wXa02rQVx2ZT5dRzpxygixahYlCHC3/KyL8Zpnjie6ilmTsu/PnvMPYtG3y3Vh2HPze8b4K0Ri6IkvTKZUVrTJo/tirPiC7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245843; c=relaxed/simple;
	bh=xbISTRKz0EJnMTmLIwLf7tT4jbcCgjF818w/ZymAGU4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZOtF7n+VQLTaooc4JMX5Twh4c1D8V07sZybCygSzXr4fCgEqHrH2zvEh3jgWP1lm+hIPt92gBvgpmBdedSnhhUk5vpA9lfCIh6ml68PX/8BG5GfKUtR0Y4IAM5DXLNNg/H4lB5EQr7Mzja40jfoHMr7pqFZRzRdOiTMS0REB2b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XsILf4Fg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZzYLnIyM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755245839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWHiph4fIINuELdt0a+NGv5gE0TDFyitr5/9rdKwdFI=;
	b=XsILf4Fgh7LpXgpzykCRN5AbgVC960WZEPgrktFrApvVr81hKqSebQ+ILc9eUyPK2i+bSm
	OFiL7HTUTDZGjy8TFSvk6pg/AFcD/k77Io39iwuBwh2MMkRCppqBtpbpTKIiRUfL5SHJIK
	x61Z1s8oZKn9PDv7y6+CQBew1LbO4Hu/5Vz1CxDGj5yfvZ2aNOTvbqdW8GZxMMGSgW9sbB
	y9JPsytamsRuX2RQSHepdeQhWvzkVI5G0VzILaykUPjR+rTLkhrkvNsB21L5TIrpICk212
	eQu6oIpOqCGvOyA8IvJXRCQLf+jRPqC51m32jCoKAm/CVVBhi8fyN24dP05Mng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755245839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PWHiph4fIINuELdt0a+NGv5gE0TDFyitr5/9rdKwdFI=;
	b=ZzYLnIyM5Mcz8s14MZmo4oDKz7Dj/ZA7J9FwJqBgpiA2IbVMrCAWt+OL4VbzSk+xU9PwVX
	Dr2FEgM2GAnYK+Bw==
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Vinicius
 Costa Gomes <vinicius.gomes@intel.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
In-Reply-To: <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
Date: Fri, 15 Aug 2025 10:17:17 +0200
Message-ID: <87y0rlm22a.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Fri Aug 15 2025, Paul Menzel wrote:
> Dear Kurt,
>
>
> Thank you for your patch.
>
> Am 15.08.25 um 08:50 schrieb Kurt Kanzenbach:
>> Retrieve Tx timestamp directly from interrupt handler.
>>=20
>> The current implementation uses schedule_work() which is executed by the
>> system work queue to retrieve Tx timestamps. This increases latency and =
can
>> lead to timeouts in case of heavy system load.
>>=20
>> Therefore, fetch the timestamp directly from the interrupt handler.
>>=20
>> The work queue code stays for the Intel 82576. Tested on Intel i210.
>
> Excuse my ignorance, I do not understand the first sentence in the last=20
> line. Is it because the driver support different models? Why not change=20
> it for Intel 82576 too?

Yes, the driver supports lots of different NIC(s). AFAICS Intel 82576 is
the only one which does not use time sync interrupts. Probably it does
not have this feature. Therefore, the 82576 needs to schedule a work
queue item.

>
> Do you have a reproducer for the issue, so others can test.

Yeah, I do have a reproducer:

 - Run ptp4l with 40ms tx timeout (--tx_timestamp_timeout)
 - Run periodic RT tasks (e.g. with SCHED_FIFO 1) with run time of
   50-100ms per CPU core

This leads to sporadic error messages from ptp4l such as "increasing
tx_timestamp_timeout or increasing kworker priority may correct this
issue, but a driver bug likely causes it"

However, increasing the kworker priority is not an option, simply
because this kworker is doing non-related PTP work items as well.

As the time sync interrupt already signals that the Tx timestamp is
available, there's no need to schedule a work item in this case. I might
have missed something though. But my testing looked good. The warn_on
never triggered.

>
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>   drivers/net/ethernet/intel/igb/igb.h      |  1 +
>>   drivers/net/ethernet/intel/igb/igb_main.c |  2 +-
>>   drivers/net/ethernet/intel/igb/igb_ptp.c  | 22 ++++++++++++++++++++++
>>   3 files changed, 24 insertions(+), 1 deletion(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet=
/intel/igb/igb.h
>> index c3f4f7cd264e9b2ff70f03b580f95b15b528028c..102ca32e8979fa3203fc2ea3=
6eac456f1943cfca 100644
>> --- a/drivers/net/ethernet/intel/igb/igb.h
>> +++ b/drivers/net/ethernet/intel/igb/igb.h
>> @@ -776,6 +776,7 @@ int igb_ptp_hwtstamp_get(struct net_device *netdev,
>>   int igb_ptp_hwtstamp_set(struct net_device *netdev,
>>   			 struct kernel_hwtstamp_config *config,
>>   			 struct netlink_ext_ack *extack);
>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter);
>>   void igb_set_flag_queue_pairs(struct igb_adapter *, const u32);
>>   unsigned int igb_get_max_rss_queues(struct igb_adapter *);
>>   #ifdef CONFIG_IGB_HWMON
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/eth=
ernet/intel/igb/igb_main.c
>> index a9a7a94ae61e93aa737b0103e00580e73601d62b..8ab6e52cb839bbb698007a74=
462798faaaab0071 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -7080,7 +7080,7 @@ static void igb_tsync_interrupt(struct igb_adapter=
 *adapter)
>>=20=20=20
>>   	if (tsicr & E1000_TSICR_TXTS) {
>>   		/* retrieve hardware timestamp */
>> -		schedule_work(&adapter->ptp_tx_work);
>> +		igb_ptp_tx_tstamp_event(adapter);
>>   	}
>>=20=20=20
>>   	if (tsicr & TSINTR_TT0)
>> diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethe=
rnet/intel/igb/igb_ptp.c
>> index a7876882aeaf2b2a7fb9ec6ff5c83d8a1b06008a..20ecafecc60557353f8cc5ab=
505030246687c8e4 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_ptp.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
>> @@ -796,6 +796,28 @@ static int igb_ptp_verify_pin(struct ptp_clock_info=
 *ptp, unsigned int pin,
>>   	return 0;
>>   }
>>=20=20=20
>> +/**
>> + * igb_ptp_tx_tstamp_event
>> + * @adapter: pointer to igb adapter
>> + *
>> + * This function checks the TSYNCTXCTL valid bit and stores the Tx hard=
ware
>> + * timestamp at the current skb.
>> + **/
>> +void igb_ptp_tx_tstamp_event(struct igb_adapter *adapter)
>> +{
>> +	struct e1000_hw *hw =3D &adapter->hw;
>> +	u32 tsynctxctl;
>> +
>> +	if (!adapter->ptp_tx_skb)
>> +		return;
>> +
>> +	tsynctxctl =3D rd32(E1000_TSYNCTXCTL);
>> +	if (WARN_ON_ONCE(!(tsynctxctl & E1000_TSYNCTXCTL_VALID)))
>> +		return;
>> +
>> +	igb_ptp_tx_hwtstamp(adapter);
>> +}
>> +
>>   /**
>>    * igb_ptp_tx_work
>>    * @work: pointer to work struct
>
> The diff looks fine.
>
> Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>

Thanks!

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmie7Q0THGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgvyEEACfDBSYsAYL9qu5zwmSqcAZklz43qTv
1VOPuLIIhUBBC+qgP5gXs6aWBrRrvP/fZ7hB3PAL6oPNV+j+/kNkxFJGPF4nWm/z
Po28nN6LYbhMMl8c0yKbqfljubPPpHP48Nda6cH6OSUtma1//+BWeYiNRQVuP7Hy
1zUVge5m1NHepOATleB1ZOELkgQZbtMUC7mKHyvk9HAuS356axxQPRJzO9WHXaV4
nMjTNv0WYeaGlw2JRuiom/7uYsZG/YEUj6NBdUmHL0QVlOTJ5QkEsfAnbOE9yWvo
ns5kmc63mxHD+DjorfqnbyprGGBhX+/xo+cbpxTVpwgW3si/rJMRnQyh+j3ZNgzE
hLjdPx2inSf94LVTgdQPs1cu5hnjN/M+fHfjRbkhHoehl9rtic69EXc1tHVtb1xD
WAZ5a3+4i09acbTvQNn/Lk40SyNCP3Abz8s1RTvh8zoT1WdtDblkGC1Sn5uYyYpw
0AJ64ZzCdqN0IpO2ge+QejMV5J99ZbILU2tWS7LVU/tkY6pbL9fT9BhXRmwpoT49
SUUHXb6poC/3fMkkPB1eiwXwkJ/IP/kse4yBVAHpQCvPB+s/aUoPOkiXM03OdIFG
1xJjViTY0CbVsz+NCLaDKR1Pn7hUmw+n+GCC8aU2XQwElwxU32UlQUKGFdN82HwO
bpD0+vrX7Plp/w==
=7AIh
-----END PGP SIGNATURE-----
--=-=-=--

