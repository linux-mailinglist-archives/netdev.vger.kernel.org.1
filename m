Return-Path: <netdev+bounces-48238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B9C7EDB56
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 06:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4681C2037B
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 05:56:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A016FC2;
	Thu, 16 Nov 2023 05:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="foxF09GJ";
	dkim=pass (2048-bit key) header.d=alu.unizg.hr header.i=@alu.unizg.hr header.b="IMNXwpkh"
X-Original-To: netdev@vger.kernel.org
Received: from domac.alu.hr (unknown [IPv6:2001:b68:2:2800::3])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07CC419B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 21:56:30 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by domac.alu.hr (Postfix) with ESMTP id BCF3E6017F;
	Thu, 16 Nov 2023 06:56:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1700114186; bh=qR+nfFmfsCr45dE7r6HfdpisVHdhPGfDi8m2E2wVsXQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=foxF09GJoFMGqWQAHq5oVlIuBloEj/1cNKdo0h2fMxFdR2Hjk9CoD2ACO9lbFYsAQ
	 NS8sdCAQnJOrnU7Q3UAgtZfCdeYJQG+3FNMV4HuDkFYV8TuXuvedaUBkurY32hBh5x
	 dzQpGwcXQwqsiKDNoxiRm4BVXMaVLB/3n5jUk0y9LbeLdDbcPJXCMAAWmLhTt1VGhP
	 WxbqCda9IQ90AAkdKf/RWVwK/Trskhla2VxqwWpbUwDqjamKBEBdWXSmJbmx3Gtu0w
	 R4T2PdpNvmGoszeu+Etr2UcS7qUUYytXiuidzT5J+4rtmJoemMad4GKS1yyFJ+RDh8
	 p4FLVqKXagEBQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
	by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LOYQIxIG_nov; Thu, 16 Nov 2023 06:56:24 +0100 (CET)
Received: from [192.168.1.3] (78-0-114-203.adsl.net.t-com.hr [78.0.114.203])
	by domac.alu.hr (Postfix) with ESMTPSA id B70FC60171;
	Thu, 16 Nov 2023 06:56:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
	t=1700114184; bh=qR+nfFmfsCr45dE7r6HfdpisVHdhPGfDi8m2E2wVsXQ=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=IMNXwpkhUI476pMe+Sd9ezPZMwgBYLSeDlM/+avWHgWwTpUROGmq0RKG5rQsFZn0X
	 mTK7eFbClFiidS99wprpCeArECQejZzb6jCmwZJSymTN95HngcT8IxbrNAn5+QVI66
	 vLSgGUybTMAhznkOLIZgBMR3wJVUB8xbUJeRL/5ZVkMh84wNJUsnQUBGqRaR1hSc3m
	 lnSUOebRAvX9ZJ9zZ/tmi4EC2QuEyk6+1mi6D44OV6707RxpyD+pedt366p6xBXNg4
	 LtM6oV9GmUipx4dKlnYrCAofmGkkbEV4VGNstsQsMC7hbzQTXQGgzX5OJ2LMp1nF97
	 nKqFPiaVUINOQ==
Message-ID: <aaed9b2b-1213-47f1-9cff-3b0f1cae2f46@alu.unizg.hr>
Date: Thu, 16 Nov 2023 06:56:22 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] r8169: improve RTL8411b phy-down fixup
Content-Language: en-US, hr
From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <f1a5f918-e9fd-48e6-8956-2c79648e563e@gmail.com>
 <0b60bd5f-a9e4-4b92-a1ea-cafe8c46aeac@alu.unizg.hr>
In-Reply-To: <0b60bd5f-a9e4-4b92-a1ea-cafe8c46aeac@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 15. 11. 2023. 23:17, Mirsad Todorovac wrote:
> On 11/13/23 20:13, Heiner Kallweit wrote:
>> Mirsad proposed a patch to reduce the number of spinlock lock/unlock
>> operations and the function code size. This can be further improved
>> because the function sets a consecutive register block.
>>
>> Suggested-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
>> ---
>>   drivers/net/ethernet/realtek/r8169_main.c | 139 +++++-----------------
>>   1 file changed, 28 insertions(+), 111 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
>> index 93929d835..e883db468 100644
>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>> @@ -3084,6 +3084,33 @@ static void rtl_hw_start_8168g_2(struct rtl8169_private *tp)
>>   	rtl_ephy_init(tp, e_info_8168g_2);
>>   }
>>   
>> +static void rtl8411b_fix_phy_down(struct rtl8169_private *tp)
>> +{
>> +	static const u16 fix_data[] = {
>> +/* 0xf800 */ 0xe008, 0xe00a, 0xe00c, 0xe00e, 0xe027, 0xe04f, 0xe05e, 0xe065,
>> +/* 0xf810 */ 0xc602, 0xbe00, 0x0000, 0xc502, 0xbd00, 0x074c, 0xc302, 0xbb00,
>> +/* 0xf820 */ 0x080a, 0x6420, 0x48c2, 0x8c20, 0xc516, 0x64a4, 0x49c0, 0xf009,
>> +/* 0xf830 */ 0x74a2, 0x8ca5, 0x74a0, 0xc50e, 0x9ca2, 0x1c11, 0x9ca0, 0xe006,
>> +/* 0xf840 */ 0x74f8, 0x48c4, 0x8cf8, 0xc404, 0xbc00, 0xc403, 0xbc00, 0x0bf2,
>> +/* 0xf850 */ 0x0c0a, 0xe434, 0xd3c0, 0x49d9, 0xf01f, 0xc526, 0x64a5, 0x1400,
>> +/* 0xf860 */ 0xf007, 0x0c01, 0x8ca5, 0x1c15, 0xc51b, 0x9ca0, 0xe013, 0xc519,
>> +/* 0xf870 */ 0x74a0, 0x48c4, 0x8ca0, 0xc516, 0x74a4, 0x48c8, 0x48ca, 0x9ca4,
>> +/* 0xf880 */ 0xc512, 0x1b00, 0x9ba0, 0x1b1c, 0x483f, 0x9ba2, 0x1b04, 0xc508,
>> +/* 0xf890 */ 0x9ba0, 0xc505, 0xbd00, 0xc502, 0xbd00, 0x0300, 0x051e, 0xe434,
>> +/* 0xf8a0 */ 0xe018, 0xe092, 0xde20, 0xd3c0, 0xc50f, 0x76a4, 0x49e3, 0xf007,
>> +/* 0xf8b0 */ 0x49c0, 0xf103, 0xc607, 0xbe00, 0xc606, 0xbe00, 0xc602, 0xbe00,
>> +/* 0xf8c0 */ 0x0c4c, 0x0c28, 0x0c2c, 0xdc00, 0xc707, 0x1d00, 0x8de2, 0x48c1,
>> +/* 0xf8d0 */ 0xc502, 0xbd00, 0x00aa, 0xe0c0, 0xc502, 0xbd00, 0x0132
>> +	};
>> +	unsigned long flags;
>> +	int i;
>> +
>> +	raw_spin_lock_irqsave(&tp->mac_ocp_lock, flags);
>> +	for (i = 0; i < ARRAY_SIZE(fix_data); i++)
>> +		__r8168_mac_ocp_write(tp, 0xf800 + 2 * i, fix_data[i]);
>> +	raw_spin_unlock_irqrestore(&tp->mac_ocp_lock, flags);
>> +}
>> +
> 
> Actually, this is much better than my patch proposal.
> 
> I was perhaps trying to make the function more (or too) general.
> 
> I made a small minimal program to programmatically test the table against the
> r8168_mac_ocp_write() embedded values, and the table fix_data[] checks OK.
> 
> Unable to test w/o a physical rtl8411b.
> 
> To verify result, I am submitting the code:
> 
> --------------------------------------------------------------------------------------
> #include <stdio.h>
> #include <stdlib.h>
> 
> int main (int argc, char argv[])
> {
>          FILE *fp_ocp;
>          char *line = NULL;
>          size_t n = 0;
>          int ln = 0;
>          unsigned int addr, value, oldaddr;
> 
>          if ((fp_ocp = fopen("mac_ocp_bulk", "r")) == NULL)
>                  perror("fopen");
>          else
>                  while (getline(&line, &n, fp_ocp) != -1) {
> 
>                          sscanf(line, "-%*s %x, %x", &addr, &value);
>                          if (ln == 0)
>                                  oldaddr = addr;
>                          else if (addr - oldaddr != 2) {
>                                  printf("%x %x not sequential!\n", oldaddr, addr);
>                                  break;
>                          }
>                          oldaddr = addr;
>                          if (ln != 0)
>                                  if (ln % 8 == 0)
>                                          printf(",\n");
>                                  else
>                                          printf(", ");
>                          if (ln % 8 == 0)
>                                  printf("/* 0x%04x */ 0x%04x", addr, value);
>                          else
>                                  printf("0x%04x", value);
>                          ln ++;
> 
>                  }
>          fclose(fp_ocp);
>          printf("\n");
> }
> ------------------------------------------------------------------------------------
> 
> Commands used:
> 
>   2086  cat fix_data | cut -c 2- > fix_cut
>   2087  ./check
>   2088  ./check > fix_cut_from_ocp
>   2089  diff fix_cut fix_cut_from_ocp

Based on the programmatic proof of the correctness of fix_data table when compared
to r8168_mac_ocp_write() sequential calls, and a suggestion from the maintainer,
I am adding a Reviewed-by: tag:

Reviewed-by: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>

>>   static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>   {
>>   	static const struct ephy_info e_info_8411_2[] = {
>> @@ -3117,117 +3144,7 @@ static void rtl_hw_start_8411_2(struct rtl8169_private *tp)
>>   	mdelay(3);
>>   	r8168_mac_ocp_write(tp, 0xFC26, 0x0000);
>>   
>> -	r8168_mac_ocp_write(tp, 0xF800, 0xE008);
>> -	r8168_mac_ocp_write(tp, 0xF802, 0xE00A);
>> -	r8168_mac_ocp_write(tp, 0xF804, 0xE00C);
>> -	r8168_mac_ocp_write(tp, 0xF806, 0xE00E);
>> -	r8168_mac_ocp_write(tp, 0xF808, 0xE027);
>> -	r8168_mac_ocp_write(tp, 0xF80A, 0xE04F);
>> -	r8168_mac_ocp_write(tp, 0xF80C, 0xE05E);
>> -	r8168_mac_ocp_write(tp, 0xF80E, 0xE065);
>> -	r8168_mac_ocp_write(tp, 0xF810, 0xC602);
>> -	r8168_mac_ocp_write(tp, 0xF812, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF814, 0x0000);
>> -	r8168_mac_ocp_write(tp, 0xF816, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF818, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF81A, 0x074C);
>> -	r8168_mac_ocp_write(tp, 0xF81C, 0xC302);
>> -	r8168_mac_ocp_write(tp, 0xF81E, 0xBB00);
>> -	r8168_mac_ocp_write(tp, 0xF820, 0x080A);
>> -	r8168_mac_ocp_write(tp, 0xF822, 0x6420);
>> -	r8168_mac_ocp_write(tp, 0xF824, 0x48C2);
>> -	r8168_mac_ocp_write(tp, 0xF826, 0x8C20);
>> -	r8168_mac_ocp_write(tp, 0xF828, 0xC516);
>> -	r8168_mac_ocp_write(tp, 0xF82A, 0x64A4);
>> -	r8168_mac_ocp_write(tp, 0xF82C, 0x49C0);
>> -	r8168_mac_ocp_write(tp, 0xF82E, 0xF009);
>> -	r8168_mac_ocp_write(tp, 0xF830, 0x74A2);
>> -	r8168_mac_ocp_write(tp, 0xF832, 0x8CA5);
>> -	r8168_mac_ocp_write(tp, 0xF834, 0x74A0);
>> -	r8168_mac_ocp_write(tp, 0xF836, 0xC50E);
>> -	r8168_mac_ocp_write(tp, 0xF838, 0x9CA2);
>> -	r8168_mac_ocp_write(tp, 0xF83A, 0x1C11);
>> -	r8168_mac_ocp_write(tp, 0xF83C, 0x9CA0);
>> -	r8168_mac_ocp_write(tp, 0xF83E, 0xE006);
>> -	r8168_mac_ocp_write(tp, 0xF840, 0x74F8);
>> -	r8168_mac_ocp_write(tp, 0xF842, 0x48C4);
>> -	r8168_mac_ocp_write(tp, 0xF844, 0x8CF8);
>> -	r8168_mac_ocp_write(tp, 0xF846, 0xC404);
>> -	r8168_mac_ocp_write(tp, 0xF848, 0xBC00);
>> -	r8168_mac_ocp_write(tp, 0xF84A, 0xC403);
>> -	r8168_mac_ocp_write(tp, 0xF84C, 0xBC00);
>> -	r8168_mac_ocp_write(tp, 0xF84E, 0x0BF2);
>> -	r8168_mac_ocp_write(tp, 0xF850, 0x0C0A);
>> -	r8168_mac_ocp_write(tp, 0xF852, 0xE434);
>> -	r8168_mac_ocp_write(tp, 0xF854, 0xD3C0);
>> -	r8168_mac_ocp_write(tp, 0xF856, 0x49D9);
>> -	r8168_mac_ocp_write(tp, 0xF858, 0xF01F);
>> -	r8168_mac_ocp_write(tp, 0xF85A, 0xC526);
>> -	r8168_mac_ocp_write(tp, 0xF85C, 0x64A5);
>> -	r8168_mac_ocp_write(tp, 0xF85E, 0x1400);
>> -	r8168_mac_ocp_write(tp, 0xF860, 0xF007);
>> -	r8168_mac_ocp_write(tp, 0xF862, 0x0C01);
>> -	r8168_mac_ocp_write(tp, 0xF864, 0x8CA5);
>> -	r8168_mac_ocp_write(tp, 0xF866, 0x1C15);
>> -	r8168_mac_ocp_write(tp, 0xF868, 0xC51B);
>> -	r8168_mac_ocp_write(tp, 0xF86A, 0x9CA0);
>> -	r8168_mac_ocp_write(tp, 0xF86C, 0xE013);
>> -	r8168_mac_ocp_write(tp, 0xF86E, 0xC519);
>> -	r8168_mac_ocp_write(tp, 0xF870, 0x74A0);
>> -	r8168_mac_ocp_write(tp, 0xF872, 0x48C4);
>> -	r8168_mac_ocp_write(tp, 0xF874, 0x8CA0);
>> -	r8168_mac_ocp_write(tp, 0xF876, 0xC516);
>> -	r8168_mac_ocp_write(tp, 0xF878, 0x74A4);
>> -	r8168_mac_ocp_write(tp, 0xF87A, 0x48C8);
>> -	r8168_mac_ocp_write(tp, 0xF87C, 0x48CA);
>> -	r8168_mac_ocp_write(tp, 0xF87E, 0x9CA4);
>> -	r8168_mac_ocp_write(tp, 0xF880, 0xC512);
>> -	r8168_mac_ocp_write(tp, 0xF882, 0x1B00);
>> -	r8168_mac_ocp_write(tp, 0xF884, 0x9BA0);
>> -	r8168_mac_ocp_write(tp, 0xF886, 0x1B1C);
>> -	r8168_mac_ocp_write(tp, 0xF888, 0x483F);
>> -	r8168_mac_ocp_write(tp, 0xF88A, 0x9BA2);
>> -	r8168_mac_ocp_write(tp, 0xF88C, 0x1B04);
>> -	r8168_mac_ocp_write(tp, 0xF88E, 0xC508);
>> -	r8168_mac_ocp_write(tp, 0xF890, 0x9BA0);
>> -	r8168_mac_ocp_write(tp, 0xF892, 0xC505);
>> -	r8168_mac_ocp_write(tp, 0xF894, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF896, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF898, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF89A, 0x0300);
>> -	r8168_mac_ocp_write(tp, 0xF89C, 0x051E);
>> -	r8168_mac_ocp_write(tp, 0xF89E, 0xE434);
>> -	r8168_mac_ocp_write(tp, 0xF8A0, 0xE018);
>> -	r8168_mac_ocp_write(tp, 0xF8A2, 0xE092);
>> -	r8168_mac_ocp_write(tp, 0xF8A4, 0xDE20);
>> -	r8168_mac_ocp_write(tp, 0xF8A6, 0xD3C0);
>> -	r8168_mac_ocp_write(tp, 0xF8A8, 0xC50F);
>> -	r8168_mac_ocp_write(tp, 0xF8AA, 0x76A4);
>> -	r8168_mac_ocp_write(tp, 0xF8AC, 0x49E3);
>> -	r8168_mac_ocp_write(tp, 0xF8AE, 0xF007);
>> -	r8168_mac_ocp_write(tp, 0xF8B0, 0x49C0);
>> -	r8168_mac_ocp_write(tp, 0xF8B2, 0xF103);
>> -	r8168_mac_ocp_write(tp, 0xF8B4, 0xC607);
>> -	r8168_mac_ocp_write(tp, 0xF8B6, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8B8, 0xC606);
>> -	r8168_mac_ocp_write(tp, 0xF8BA, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8BC, 0xC602);
>> -	r8168_mac_ocp_write(tp, 0xF8BE, 0xBE00);
>> -	r8168_mac_ocp_write(tp, 0xF8C0, 0x0C4C);
>> -	r8168_mac_ocp_write(tp, 0xF8C2, 0x0C28);
>> -	r8168_mac_ocp_write(tp, 0xF8C4, 0x0C2C);
>> -	r8168_mac_ocp_write(tp, 0xF8C6, 0xDC00);
>> -	r8168_mac_ocp_write(tp, 0xF8C8, 0xC707);
>> -	r8168_mac_ocp_write(tp, 0xF8CA, 0x1D00);
>> -	r8168_mac_ocp_write(tp, 0xF8CC, 0x8DE2);
>> -	r8168_mac_ocp_write(tp, 0xF8CE, 0x48C1);
>> -	r8168_mac_ocp_write(tp, 0xF8D0, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF8D2, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF8D4, 0x00AA);
>> -	r8168_mac_ocp_write(tp, 0xF8D6, 0xE0C0);
>> -	r8168_mac_ocp_write(tp, 0xF8D8, 0xC502);
>> -	r8168_mac_ocp_write(tp, 0xF8DA, 0xBD00);
>> -	r8168_mac_ocp_write(tp, 0xF8DC, 0x0132);
>> +	rtl8411b_fix_phy_down(tp);
>>   
>>   	r8168_mac_ocp_write(tp, 0xFC26, 0x8000);
>>   

-- 
Mirsad Goran Todorovac
Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu
 
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb, Republic of Croatia
The European Union

"I see something approaching fast ... Will it be friends with me?"


