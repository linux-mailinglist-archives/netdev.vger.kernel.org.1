Return-Path: <netdev+bounces-39396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F05F17BEFE9
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A98C28121C
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 00:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16C37F;
	Tue, 10 Oct 2023 00:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EFD377
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:51:10 +0000 (UTC)
X-Greylist: delayed 2146 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 17:51:05 PDT
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A135DA9
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 17:51:05 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:38784)
	by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qq0P7-006rhm-3N; Mon, 09 Oct 2023 18:15:17 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:32870 helo=email.froward.int.ebiederm.org.xmission.com)
	by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.93)
	(envelope-from <ebiederm@xmission.com>)
	id 1qq0P5-008HVS-LF; Mon, 09 Oct 2023 18:15:16 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: David Ahern <dsahern@gmail.com>,  Stephen Hemminger
 <stephen@networkplumber.org>,  netdev@vger.kernel.org,  Nicolas Dichtel
 <nicolas.dichtel@6wind.com>,  Christian Brauner <brauner@kernel.org>,
  David Laight <David.Laight@ACULAB.COM>
References: <20231009182753.851551-1-toke@redhat.com>
	<877cnvtu37.fsf@email.froward.int.ebiederm.org>
	<87jzrvzc5v.fsf@toke.dk>
Date: Mon, 09 Oct 2023 19:14:37 -0500
In-Reply-To: <87jzrvzc5v.fsf@toke.dk> ("Toke =?utf-8?Q?H=C3=B8iland-J?=
 =?utf-8?Q?=C3=B8rgensen=22's?= message of
	"Tue, 10 Oct 2023 00:03:24 +0200")
Message-ID: <87ttqznxjm.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-XM-SPF: eid=1qq0P5-008HVS-LF;;;mid=<87ttqznxjm.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX18oUAJ35whwkq4pC6OnIRHRRsRMSBnyHCM=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAD_ENC_HEADER,BAYES_00,
	RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: =?ISO-8859-1?Q?;Toke H=c3=b8iland-J=c3=b8rgensen <toke@redhat.com>?=
X-Spam-Relay-Country: 
X-Spam-Timing: total 720 ms - load_scoreonly_sql: 0.08 (0.0%),
	signal_user_changed: 12 (1.7%), b_tie_ro: 10 (1.4%), parse: 1.46
	(0.2%), extract_message_metadata: 17 (2.3%), get_uri_detail_list: 4.9
	(0.7%), tests_pri_-2000: 15 (2.0%), tests_pri_-1000: 2.7 (0.4%),
	tests_pri_-950: 1.32 (0.2%), tests_pri_-900: 1.06 (0.1%),
	tests_pri_-200: 0.90 (0.1%), tests_pri_-100: 4.1 (0.6%),
	tests_pri_-90: 77 (10.8%), check_bayes: 76 (10.5%), b_tokenize: 14
	(2.0%), b_tok_get_all: 15 (2.1%), b_comp_prob: 6 (0.9%),
	b_tok_touch_all: 35 (4.8%), b_finish: 1.06 (0.1%), tests_pri_0: 575
	(79.8%), check_dkim_signature: 0.89 (0.1%), check_dkim_adsp: 3.3
	(0.5%), poll_dns_idle: 1.28 (0.2%), tests_pri_10: 2.1 (0.3%),
	tests_pri_500: 7 (1.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH iproute2-next 0/5] Persisting of mount namespaces
 along with network namespaces
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)

Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:

> "Eric W. Biederman" <ebiederm@xmission.com> writes:
>
>> Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com> writes:
>>
>>> The 'ip netns' command is used for setting up network namespaces with p=
ersistent
>>> named references, and is integrated into various other commands of ipro=
ute2 via
>>> the -n switch.
>>>
>>> This is useful both for testing setups and for simple script-based name=
spacing
>>> but has one drawback: the lack of persistent mounts inside the spawned
>>> namespace. This is particularly apparent when working with BPF programs=
 that use
>>> pinning to bpffs: by default no bpffs is available inside a namespace, =
and
>>> even if mounting one, that fs disappears as soon as the calling
>>> command exits.
>>
>> It would be entirely reasonable to copy mounts like /sys/fs/bpf from the
>> original mount namespace into the temporary mount namespace used by
>> "ip netns".
>>
>> I would call it a bug that "ip netns" doesn't do that already.
>>
>> I suspect that "ip netns" does copy the mounts from the old sysfs onto
>> the new sysfs is your entire problem.
>
> How would it do that? Walk mtab and remount everything identically after
> remounting /sys? Or is there a smarter way to go about this?

There are not many places to look so something like this is probably suffic=
ient:

# stat all of the possible/probable mount points and see if there is
# something mounted there.  If so recursive bind whatever is there onto
# the new /sys

for dir in /old/sys/fs/* /old/sys/kernel/*; do
	if [ $(stat --format '%d' "$dir") =3D $(stat --format '%d' "$dir/") ; then
		newdir =3D $(echo $dir | sed -e s/old/new/)
		mount --rbind $dir/ $newdir/
	fi=20=20
done

If the concern is being robust for the future the mount points can also
be enumerated by looking in one of /proc/self/mounts,
/proc/self/mountinfo, or /proc/self/mountstats.

I am not certain which is less work parsing a file with lots of fields,
or reading a directory and stating the returned files from readdir.

>> Or is their a reason that bpffs should be per network namespace?
>
> Well, I first ran into this issue because of a bug report to
> xdp-tools/libxdp about things not working correctly in network
> namespaces:
>
> https://github.com/xdp-project/xdp-tools/issues/364
>
> And libxdp does assume that there's a separate bpffs per network
> namespace: it persists things into the bpffs that is tied to the network
> devices in the current namespace. So if the bpffs is shared, an
> application running inside the network namespace could access XDP
> programs loaded in the root namespace. I don't know, but suspect, that
> such assumptions would be relatively common in networking BPF programs
> that use pinning (the pinning support in libbpf and iproute2 itself at
> least have the same leaking problem if the bpffs is shared).

Are the names of the values truly network namespace specific?

I did not see any mention of the things that are persisted in the ticket
you pointed me at, and unfortunately I am not familiar with xdp.

Last I looked until all of the cpu side channels are closed it is
unfortunately unsafe to load ebpf programs with anything less than
CAP_SYS_ADMIN (aka with permission to see and administer the entire
system).  So from a system point of view I really don't see a
fundamental danger from having a global /sys/fs/bpf.

If there are name conflicts in /sys/fs/bpf because of duplicate names in
different network namespaces I can see that being a problem.

At that point the name conflicts either need to be fixed or we
fundamentally need to have multiple mount points for bpffs.
Probably under something like /run/netns-mounts/NAME/.

With ip netns updated to mount the appropriate filesystem.


>>> The underlying cause for this is that iproute2 will create a new mount =
namespace
>>> every time it switches into a network namespace. This is needed to be a=
ble to
>>> mount a /sys filesystem that shows the correct network device informati=
on, but
>>> has the unfortunate side effect of making mounts entirely transient for=
 any 'ip
>>> netns' invocation.
>>
>> Mount propagation can be made to work if necessary, that would solve the
>> transient problem.
>
> Is mount propagation different from the remount thing you mentioned
> above, or is this something different?
>
> (Sorry for being hopelessly naive about this, as you probably guessed
> from my previous email asking about this, I'm only now learning about
> all the intricacies fs mounts).

Mount propagation is a way to configure a mount namespace (before
creating a new one) that will cause mounts created in the first mount
namespace to be created in it's children, and cause mounts created in
the children to be created in the parent (depending on how things are
configured).

It is not my favorite feature (it makes locking of mount namespaces
terrible) and it is probably too clever by half, unfortunately systemd
started enabling mount propagation by default, so we are stuck with it.

>>> This series is an attempt to fix this situation, by persisting a mount =
namespace
>>> alongside the persistent network namespace (in a separate directory,
>>> /run/netns-mnt). Doing this allows us to still have a consistent /sys i=
nside
>>> the namespace, but with persistence so any mounts survive.
>>
>> I really don't like that direction.
>>
>> "ip netns" was designed and really should continue to be a command that
>> makes the world look like it has a single network namespace, for
>> compatibility with old code.  Part of that old code "ip netns" supports
>> is "ip" itself.
>
> Well my idea with this change was to keep the functionality as close to
> what 'ip' currently does, but just have mounts persist across
> invocations.
>
>> I think you are making bpffs unnecessarily per network namespace.
>
> See above.=20
>
>>> This mode does come with some caveats. I'm sending this as RFC to get f=
eedback
>>> on whether this is the right thing to do, especially considering backwa=
rds
>>> compatibility. On balance, I think that the approach taken here of
>>> unconditionally persisting the mount namespace, and using that persiste=
nt
>>> reference whenever it exists, is better than the current behaviour, and=
 that
>>> while it does represent a change in behaviour it is backwards compatibl=
e in a
>>> way that won't cause issues. But please do comment on this; see the pat=
ch
>>> description of patch 4 for details.
>>
>> As I understand it this will cause a problem for any application that
>> is network namespace aware and does not use "ip netns" to wrap itself.
>>
>> I am fairly certain that pinning the mount namespace will result in
>> never seeing an update of /etc/resolve.conf.  At least if you
>> are on a system that has /etc/netns/NAME/resolve.conf
>
> I was actually wondering about that /etc bind mounting support while I
> was looking at this code. Could you please elaborate a bit on what that
> is used for, exactly? :)

The idea is that you can have separate static configuration depending
upon your network namespace.

A real world case is vpning into several company internal networks.
Each company network uses overlapping portions of the 192.168.x.x
network.
Each company network will want it's own dns servers and possibly other
network configuration as well.

For it to make sense you really only need one company network and a home
network.  One of which you could stash in a network namespace to prevent
conflicts.

I don't know if supporting that ever caught on very strongly, but
I tried to build a template that would work for that and similar cases.

> Also, if staleness of the /etc bind mounts is an issue, those could be
> redone on every entry, couldn't they?

They already are ;)

Eric


