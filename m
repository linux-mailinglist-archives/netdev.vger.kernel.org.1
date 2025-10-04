Return-Path: <netdev+bounces-227856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 746B0BB8D3F
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 14:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 55C614E1982
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 12:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2224A267B01;
	Sat,  4 Oct 2025 12:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWzYTXfT"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545B420B7EE
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 12:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759581236; cv=none; b=DDVkNHpLoi16B1nSAXxpdfNmubKVD2HjH6NLrj8Y1OidUa4buYEqxIb2aoi8DYIjd5psqSKUvEyI+s+fHUWjzKJrNeaVAsY7Mwlkd6NDeEdKAD5xHENIt20+iBXrF1tL8mmNEJJFVlcTFqeb7AfGrZ1krHiV6+Ec3RujT8DCRp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759581236; c=relaxed/simple;
	bh=sb+yz92QNllJRfZP6kCK0MG9BJGxb11uZOX19JFHork=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iiYfILBorWBH/U+PbEx48tqXS+EcXC4MlkVT4XDPtpAYW+Fdri3l/xZOW2fhOqXqgzSuP0/vT6Fblo3SMhilgm4viEiqrWmTxWLRYL0UBJdb0YySHAHGLR0bL78HqevXGPn45N+i/Hp0EZVTmquz3GjN7StyjFePrnec5KTbcgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWzYTXfT; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2fe84499-b768-49b5-bf0c-3264f8598f9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759581231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TdKzdni977FRvZL2mxhS19BIqE4cwVIXnUE4lWZ5wvI=;
	b=pWzYTXfTmjU0GHucRq+k1uxXISwCrOA1HjrScQcq0j0x9nvLYSD34eYpRftt8HYEN/dipu
	OfUokqgO5fXphhUQ/SiZlokCDJOmwrTvhqf7d6QpOrq4UJcQsIzYRebmtOvQeOn5yMp6DC
	M/A+89376/+G+tgc4EDwuHT/78DSMtI=
Date: Sat, 4 Oct 2025 13:33:47 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [External] : [PATCH ethtool-next] netlink: fec: add errors
 histogram statistics
To: ALOK TIWARI <alok.a.tiwari@oracle.com>, mkubecek@suse.cz
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20251003225253.3291333-1-vadim.fedorenko@linux.dev>
 <599e8a11-3276-4d67-8ef6-c335be560ea8@oracle.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <599e8a11-3276-4d67-8ef6-c335be560ea8@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 04/10/2025 10:53, ALOK TIWARI wrote:
> 
> 
> On 10/4/2025 4:22 AM, Vadim Fedorenko wrote:
>> Linux 6.18 has FEC errors histogram statistics API added. Add support
>> for extra attributes in ethtool.
>>
>>   # ethtool -I --show-fec eni8np1
>> FEC parameters for eni8np1:
>> Supported/Configured FEC encodings: None
>> Active FEC encoding: None
>> Statistics:
>>    corrected_blocks: 123
>>    uncorrectable_blocks: 4
>>    fec_bit_err_0: 445 [ per_lane:  125, 120, 100, 100 ]
>>    fec_bit_err_1_to_3: 12
>>    fec_bit_err_4_to_7: 2
>>
>>   # ethtool -j -I --show-fec eni8np1
>> [ {
>>          "ifname": "eni8np1",
>>          "config": [ "None" ],
>>          "active": [ "None" ],
>>          "statistics": {
>>              "corrected_blocks": {
>>                  "total": 123
>>              },
>>              "uncorrectable_blocks": {
>>                  "total": 4
>>              },
>>              "hist": [ {
>>                      "bin_low": 0,
>>                      "bin_high": 0,
>>                      "total": 445,
>>                      "lanes": [ 125,120,100,100 ]
>>                  },{
>>                      "bin_low": 1,
>>                      "bin_high": 3,
>>                      "total": 12
>>                  },{
>>                      "bin_low": 4,
>>                      "bin_high": 7,
>>                      "total": 2
>>                  } ]
>>          }
>>      } ]
>>
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>> ---
>>   netlink/fec.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 72 insertions(+)
>>
>> diff --git a/netlink/fec.c b/netlink/fec.c
>> index ed100d7..32f7ca7 100644
>> --- a/netlink/fec.c
>> +++ b/netlink/fec.c
>> @@ -44,6 +44,64 @@ fec_mode_walk(unsigned int idx, const char *name, 
>> bool val, void *data)
>>       print_string(PRINT_ANY, NULL, " %s", name);
>>   }
>> +static void fec_show_hist_bin(const struct nlattr *hist)
>> +{
>> +    const struct nlattr *tb[ETHTOOL_A_FEC_HIST_MAX + 1] = {};
>> +    DECLARE_ATTR_TB_INFO(tb);
>> +    unsigned int i, lanes, bin_high, bin_low;
>> +    uint64_t val, *vals;
>> +    int ret;
>> +
>> +    ret = mnl_attr_parse_nested(hist, attr_cb, &tb_info);
>> +    if (ret < 0)
>> +        return;
>> +
>> +    if (!tb[ETHTOOL_A_FEC_HIST_BIN_LOW] || ! 
>> tb[ETHTOOL_A_FEC_HIST_BIN_HIGH])
>> +        return;
>> +
>> +    bin_high = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_HIGH]);
>> +    bin_low  = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_LOW]);
>> +    /* Bin value is uint, so it may be u32 or u64 depeding on the 
>> value */
> 
> typo depeding -> depending

yep, missed it..

> 
>> +    if (mnl_attr_validate(tb[ETHTOOL_A_FEC_HIST_BIN_VAL], 
>> MNL_TYPE_U32) < 0)
>> +        val = mnl_attr_get_u64(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
>> +    else
>> +        val = mnl_attr_get_u32(tb[ETHTOOL_A_FEC_HIST_BIN_VAL]);
>> +
>> +    if (is_json_context()) {
>> +        print_u64(PRINT_JSON, "bin_low", NULL, bin_low);
>> +        print_u64(PRINT_JSON, "bin_high", NULL, bin_high);
>> +        print_u64(PRINT_JSON, "total", NULL, val);
>> +    } else {
>> +        printf("  fec_bit_err_%d", bin_low);
>> +        if (bin_low != bin_high)
>> +            printf("_to_%d", bin_high);
>> +        printf(": %" PRIu64, val);
>> +    }
>> +    if (!tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) {
>> +        if (!is_json_context())
>> +            print_nl();
>> +        return;
>> +    }
>> +
>> +    vals = 
>> mnl_attr_get_payload(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]);
>> +    lanes = 
>> mnl_attr_get_payload_len(tb[ETHTOOL_A_FEC_HIST_BIN_VAL_PER_LANE]) / 8;
> 
> 8 -> sizeof(uint64_t)
There is no history of using sizeof(uint64_t) in code base, but the 
codearound uses "/ 8" and "% 8" for u64 attributes.

>> +    if (is_json_context())
>> +        open_json_array("lanes", "");
>> +    else
>> +        printf(" [ per_lane:");
>> +    for (i = 0; i < lanes; i++) {
>> +        if (is_json_context())
>> +            print_u64(PRINT_JSON, NULL, NULL, *vals++);
>> +        else
>> +            printf("%s %" PRIu64, i ? "," : "", *vals++);
> 
> "" -> " "
That will break formatting. Empty string is intended here.

> 
>> +    }
>> +
>> +    if (is_json_context())
>> +        close_json_array("");
>> +    else
>> +        printf(" ]\n");
>> +}
>> +
>>   static int fec_show_stats(const struct nlattr *nest)
>>   {
>>       const struct nlattr *tb[ETHTOOL_A_FEC_STAT_MAX + 1] = {};
>> @@ -108,6 +166,20 @@ static int fec_show_stats(const struct nlattr *nest)
>>           close_json_object();
>>       }
>> +
>> +    if (tb[ETHTOOL_A_FEC_STAT_HIST]) {
>> +        const struct nlattr *attr;
>> +
>> +        open_json_array("hist", "");
>> +        mnl_attr_for_each_nested(attr, nest) {
> 
> "mnl_attr_for_each_nested(attr, nest) {" or 
> "mnl_attr_for_each_nested(attr, tb[ETHTOOL_A_FEC_STAT_HIST]) {" ? please 
> check it

tb[ETHTOOL_A_FEC_STAT_HIST] will not have nested attributes of type
ETHTOOL_A_FEC_STAT_HIST, the correct way is the one in the patch

>> +            if (mnl_attr_get_type(attr) == ETHTOOL_A_FEC_STAT_HIST) {
>> +                open_json_object(NULL);
>> +                fec_show_hist_bin(attr);
>> +                close_json_object();
>> +            }
>> +        }
>> +        close_json_array("");
>> +    }
>>       close_json_object();
>>       return 0;
> 
> Thanks,
> Alok
> 


